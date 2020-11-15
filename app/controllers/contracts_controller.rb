class ContractsController < ApplicationController
  before_action :set_contract, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_account!, except: [:show, :index]

  # GET /contracts
  # GET /contracts.json
  def index
    @contracts = Contract.all
  end

  # GET /contracts/1
  # GET /contracts/1.json
  def show
    require 'rqrcode'

    qrcode = RQRCode::QRCode.new("http://github.com/")

    # NOTE: showing with default options specified explicitly
    @qr_svg = qrcode.as_svg(
      offset: 0,
      color: '000',
      shape_rendering: 'crispEdges',
      module_size: 6,
      standalone: true
    )

  end

  # user joins into a contract
  # GET /join/contract_id
  def join
    @contract = Contract.find(params[:contract_id])

    # test if person has already joined this contract.
    if has_account_already_joined_the_contract current_account.id, @contract.id
      flash[:notice] = 'Already successfully joined the contract.'
      redirect_to @contract
      return
    end

    @party = Party.new(:account_id => current_account.id, :contract_id => @contract.id)

    respond_to do |format|
      if @party.save
        format.html { redirect_to @contract, notice: 'Joined successfully.' }
        format.json { render :show, status: :created, location: @contract }
      else
        format.html { render :show }
        format.json { render json: @contract.errors, status: :unprocessable_entity }
      end
    end
  end

  # GET /contracts/new
  def new
    @contract = Contract.new
  end

  # GET /contracts/1/edit
  def edit
  end

  # POST /contracts
  # POST /contracts.json
  def create
    @contract = Contract.new(contract_params)

    respond_to do |format|
      if @contract.save
        format.html { redirect_to @contract, notice: 'Contract was successfully created.' }
        format.json { render :show, status: :created, location: @contract }
      else
        format.html { render :new }
        format.json { render json: @contract.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /contracts/1
  # PATCH/PUT /contracts/1.json
  def update
    respond_to do |format|
      if @contract.update(contract_params)
        format.html { redirect_to @contract, notice: 'Contract was successfully updated.' }
        format.json { render :show, status: :ok, location: @contract }
      else
        format.html { render :edit }
        format.json { render json: @contract.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /contracts/1
  # DELETE /contracts/1.json
  def destroy
    @contract.destroy
    respond_to do |format|
      format.html { redirect_to contracts_url, notice: 'Contract was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def has_account_already_joined_the_contract(id_of_account, id_of_contract)
      return Party.where(:account_id => id_of_account, :contract_id => id_of_contract).length > 0
    end
    # Use callbacks to share common setup or constraints between actions.
    def set_contract
      @contract = Contract.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def contract_params
      params.require(:contract).permit(:title, :content)
    end
end
