Rails.application.config.active_storage.routes_prefix = '/legacy-storage'
Rails.application.config.active_storage.queues.analysis = :legacy_active_storage_analysis
Rails.application.config.active_storage.queues.purge    = :legacy_active_storage_purge
