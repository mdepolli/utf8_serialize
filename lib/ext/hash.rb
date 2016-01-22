class Hash
  # recursively converts all strings to utf8
  def to_utf8
    Hash[
      self.collect do |k, v|
        if v.respond_to?(:to_utf8)
          [k, v.to_utf8]
        elsif v.respond_to?(:encoding)
          [k, v.dup.force_encoding('UTF-8')]
        else
          [k, v]
        end
      end
    ]
  end
end
