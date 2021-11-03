# frozen_string_literal: true

class ImportTicketToEsGateway
  class << self
    def bulk_import(ticket_ids: nil) 
      # Elasticsearchへの
      config = YAML.load_file(Rails.root.join('config/elasticsearch.yml'))[ENV['RAILS_ENV'] || 'development']
      client = Elasticsearch::Client.new(host: config['host'])

      if ticket_ids.nil? 
        all_tickets =
          Ticket.eager_load(:user).all
      else
        all_tickets = Ticket.eager_load(:user).where(id: ticket_ids)
      end
      # bulkで入れる
      all_tickets.find_in_batches(batch_size: 500).with_index do |tickets, i|
        client.bulk(
          index: 'es_tickets',
          type: '_doc',
          body: tickets.map { |ticket| { index: { _id: ticket.id, data: as_indexed_json(ticket) } } },
          refresh: (i > 0 && i % 3 == 0), # NOTE: 定期的にrefreshしないとEsが重くなる
        )
      end
    end

    private
  
    def as_indexed_json(ticket)
      {
         id: ticket.id,
         title: ticket.title,
         title2: ticket.title,
         description: ticket.description,
         description2: ticket.description,
         point: ticket.point,
         creator_name: ticket.user.name,
         created_at: ticket.created_at,
         updated_at: ticket.updated_at 
      }.to_json
    end
  end
end
