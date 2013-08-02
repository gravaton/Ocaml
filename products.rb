#!/usr/local/bin/ruby

def choosenum(avail, count, selected = [])
	return [[selected,avail]] if count == 0
	output = []
	avail.length.times { |i|
		cur = avail.rotate(i)
		newsel = selected + [ cur.shift ]
		output.concat(choosenum(cur, count - 1, newsel))
	}
	return output
end

def testout(nums, leftover)
	output = []
	total = nums[0,4].join.to_i * nums[4]
	ary = total.to_s.scan(/\d/).map(&:to_i)
	if ary.sort == leftover.sort
		print "#{nums[0,4].join} * #{nums[4]} = #{total} WORKS!\n"
		output << total
	end
	total = nums[0,3].join.to_i * nums[3,2].join.to_i
	ary = total.to_s.scan(/\d/).map(&:to_i)
	if ary.sort == leftover.sort
		print "#{nums[0,3].join} * #{nums[3,2].join} = #{total} WORKS!\n"
		output << total
	end
	return output
end

outputs = choosenum([1,2,3,4,5,6,7,8,9], 5)

works = []
outputs.each { |i|
	works.concat(testout(i[0],i[1]))
}

print works.uniq.inject(:+), "\n"
