require_relative './../../spec_helper.rb'

#Test responsable for return list of faq, search is correct for category or question and answer
describe FaqModule::ListService do
  before do
    #create a company and associated
    @company = create(:company)
  end

  describe '#call' do
    it "with list command: With zero faqs, return don't find message" do
      #list not necessity parameters
      @listService = FaqModule::ListService.new({}, 'list')

      #call and wait not found
      response = @listService.call()
      expect(response).to match("Nada encontrado")
    end

    it "With two faqs, find questions and answer in response" do
      @listService = FaqModule::ListService.new({}, 'list')

      #create a factory
      faq1 = create(:faq, company: @company)
      faq2 = create(:faq, company: @company)

      #list of commands question and answer
      response = @listService.call()

      #if exists the questions
      expect(response).to match(faq1.question)
      expect(response).to match(faq1.answer)

      expect(response).to match(faq2.question)
      expect(response).to match(faq2.answer)
    end

    #when send query empty return don't find
    it "with search command: With empty query, return don't find message" do
      @listService = FaqModule::ListService.new({'query' => ''}, 'search')

      response = @listService.call()
      expect(response).to match("Nada encontrado")
    end

    it "with search command: With valid query, find question and answer in response" do
      #create new faq
      faq = create(:faq, company: @company)

      #separate in space and sample sorted someone array word
      @listService = FaqModule::ListService.new({'query' => faq.question.split(" ").sample}, 'search')

      #call list
      response = @listService.call()

      #verificate if reponse is correct
      expect(response).to match(faq.question)
      expect(response).to match(faq.answer)
    end

    it "with search_by_hashtag command: With invalid hashtag, return don't find message" do
      #passed hashtag empty
      @listService = FaqModule::ListService.new({'query' => ''}, 'search_by_hashtag')

      #call list
      response = @listService.call()
      #return message not found
      expect(response).to match("Nada encontrado")
    end

    it "with search_by_hashtag command: With valid hashtag, find question and answer in response" do

      #create a faq
      faq = create(:faq, company: @company)
      #create a hashtag associated a same company
      hashtag = create(:hashtag, company: @company)
      #create intermediate beetween hashtag and faq
      create(:faq_hashtag, faq: faq, hashtag: hashtag)

      #get hashtag.name and passed with parameters
      @listService = FaqModule::ListService.new({'query' => hashtag.name}, 'search_by_hashtag')

      #call service
      response = @listService.call()

      #show the answer and question
      expect(response).to match(faq.question)
      expect(response).to match(faq.answer)
    end
  end
end
