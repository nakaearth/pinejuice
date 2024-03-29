# frozen_string_literal: true

class ImportTicketToEsGateway
  class << self
    def bulk_import(ticket_ids: nil)
      # Elasticsearchへの
      config = YAML.load_file(Rails.root.join('config/elasticsearch.yml'))[ENV['RAILS_ENV'] || 'development']
      client = Elasticsearch::Client.new(host: config['host'])

      all_tickets = if ticket_ids.nil?
                      Ticket.eager_load(:user).all
                    else
                      Ticket.eager_load(:user).where(id: ticket_ids)
                    end
      # bulkで入れる
      all_tickets.find_in_batches(batch_size: 500) do |tickets|
        client.bulk(
          index: 'es_tickets',
          body: tickets.map { |ticket| { index: { _id: ticket.id, data: JSON.parse(as_indexed_json(ticket)) } } },
          refresh: 'true'
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
        user_id: ticket.user.id,
        creator_name: ticket.user.name,
        created_at: ticket.created_at,
        updated_at: ticket.updated_at
      }.to_json
    end
  end
end
