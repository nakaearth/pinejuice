# frozen_string_literal: true

class SetupIndexElasticsearchGateway
  class << self
    SETTINGS = {
      index: {
        number_of_shards: 2,
        number_of_replicas: 1,
        max_result_window: 1_000_000
      },
      analysis: {
        filter: {
          pos_filter: {
            type: 'kuromoji_part_of_speech',
            stoptags: %w[助詞-格助詞-一般 助詞-終助詞]
          },
          greek_lowercase_filter: {
            type: 'lowercase',
            language: 'greek'
          },
          kuromoji_ks: {
            type: 'kuromoji_stemmer',
            minimum_length: '5'
          }
        },
        tokenizer: {
          kuromoji: {
            type: 'kuromoji_tokenizer'
          },
          ngram_tokenizer: {
            type: 'ngram',
            min_gram: '2',
            max_gram: '3',
            token_chars: %w[letter digit]
          }
        },
        analyzer: {
          kuromoji_analyzer: {
            type: 'custom',
            tokenizer: 'kuromoji_tokenizer',
            filter: %w[kuromoji_baseform pos_filter greek_lowercase_filter cjk_width]
          },
          ngram_analyzer: {
            tokenizer: 'ngram_tokenizer'
          },
          nfkc_cf_normalized: {
            tokenizer: 'icu_tokenizer',
            char_filter: ['icu_normalizer']
          },
          nfd_normalized: {
            tokenizer: 'icu_tokenizer',
            char_filter: ['nfd_normalizer']
          }
        },
        char_filter: {
          nfd_normalizer: {
            type: 'icu_normalizer',
            name: 'nfc',
            mode: 'decompose'
          }
        }
      }
    }.freeze
    MAPPINGS = {
      properties: {
        id: {
          type: 'long'
        },
        description: {
          type: 'text',
          analyzer: 'kuromoji_analyzer'
        },
        description2: {
          type: 'text',
          analyzer: 'ngram_analyzer'
        },
        title: {
          type: 'text',
          fields: {
            raw: {
              type: 'keyword'
            }
          },
          analyzer: 'kuromoji_analyzer'
        },
        title2: {
          type: 'text',
          analyzer: 'ngram_analyzer'
        },
        point: {
          type: 'long'
        },
        created_at: {
          type: 'date',
          format: 'strict_date_optional_time||epoch_millis'
        },
        updated_at: {
          type: 'date',
          format: 'strict_date_optional_time||epoch_millis'
        },
        user_id: {
          type: 'long'
        },
        creator_name: {
          type: 'text',
          fields: {
            raw: {
              type: 'keyword'
            }
          },
          analyzer: 'kuromoji_analyzer'
        }
      }
    }.freeze

    def create_index(override: false)
      config = YAML.load_file(Rails.root.join('config/elasticsearch.yml'))[ENV['RAILS_ENV'] || 'development']
      client = Elasticsearch::Client.new(host: config['host'])
      # mapping/indexの作成
      index_name = 'es_tickets'
      client.indices.delete(index: index_name) if override && client.indices.exists(index: index_name)
      client.indices.create(index: index_name,
                            body: {
                              settings: SETTINGS,
                              mappings: MAPPINGS
                            })
    end
  end
end
