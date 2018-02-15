require_relative './../../spec_helper.rb'

describe FaqModule::RemoveService do
  before do
    #create a company
    @company = create(:company)
  end

  describe '#call' do
    it "With valid ID, remove Faq" do
      #create a fact passed um object with id
      faq = create(:faq, company: @company)
      @removeService = FaqModule::RemoveService.new({"id" => faq.id})

      #call service
      response = @removeService.call()

      #return message success
      expect(response).to match("Deletado com sucesso")
      #remove for id
    end

    it "With invalid ID, receive error message" do
      #if remove question with invalid id - generate a sorted id
      @removeService = FaqModule::RemoveService.new({"id" => rand(1..9999)})

      #call
      response = @removeService.call()

      #return invalid question
      expect(response).to match("Questão inválida, verifique o Id")
    end

    it "With valid ID, remove Faq from database" do
      faq = create(:faq, company: @company)
      @removeService = FaqModule::RemoveService.new({"id" => faq.id})

      expect(Faq.all.count).to eq(1)
      response = @removeService.call()
      expect(Faq.all.count).to eq(0)
    end
  end
end
