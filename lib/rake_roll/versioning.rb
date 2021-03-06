module RakeRoll

  class Versioning

    attr_reader :current_version

    def initialize(current_version)
      @current_version = validate_current_version(current_version)
    end

    def pre
      return unless current_version
      if nums = current_version.dup
        pre_letter = nums[-1].scan(/\D/).first
        if pre_letter
          next_letter = pre_letter.next
          nums[-1].gsub!(pre_letter, next_letter)
        else
          nums[-1] = nums[-1] + "a"
        end
        nums.join(".")
      end
    end

    def revision
      return unless current_version
      if nums = current_version.dup
        last_number = nums[-1].scan(/\d+/).first.to_i
        last_number = last_number + 1
        nums[-1] = last_number
        nums.join(".")
      end
    end

    def bump_example
      return unless current_version
      if nums = current_version.dup
        last_number = nums[-1].scan(/\d+/).first.to_i
        last_number = last_number + 5
        nums[-1] = last_number
        nums.join(".")
      end
    end

    def minor
      return unless current_version
      if nums = current_version.dup
        minor_number = nums[1].scan(/\d+/).first.to_i
        minor_number = minor_number + 1
        nums[1] = minor_number.to_s
        nums.last.gsub!(/\D/, "")
        nums[-1] = "0" if nums.length == 3
        nums.join(".")
      end
    end

    def major
      return unless current_version
      if nums = current_version.dup
        major_number = nums[0].scan(/\d+/).first.to_i
        major_number = major_number + 1
        nums[0] = major_number
        nums[-1] = "0"
        nums[-2] = "0" if nums.length == 3
        nums.join(".")
      end
    end

    def next
      'NEXT'
    end

    private

    def validate_current_version(current)
      return unless current
      splits = current.split(".")
      splits.size < 2 || splits.size > 3 ? false : splits
    end

  end

end
