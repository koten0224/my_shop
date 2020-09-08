module ValidFormats
  PUNCTUATIONS = InvalidFormats::HALF_SHAPE_PUNCTUATIONS.map{|s|'\\' + s}.join
  USER_NAME_REGEX = /\A[^#{PUNCTUATIONS}]+/
end