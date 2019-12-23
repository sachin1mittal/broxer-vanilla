puts 'Starting Jobs Metadatas'

metadatas = Metadata.all

Job.all.each do |job|
  metadata = metadatas.sample

  3.times do
    allowed_values = metadata.allowed_values.split(', ')
    values = allowed_values.sample

    JobsMetadata.create!(
      job: job,
      metadata: metadata,
      values: [values]
    )
  end
end

puts 'Completed Jobs Metadatas'
