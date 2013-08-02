#!/usr/local/bin/ruby

def digit(a, b, n)
	grabdig(a, b, n, fibbo(a, b, n)[0])
end

def fibbo(a, b, n, cur = ["b",b.length], prev = ["a",a.length])
	if cur[1] > n
		print "Found fibbo\n"
		return cur
	end
	fibbo(a, b, n, [prev[0] + cur[0], prev[1] + cur[1]], cur)
end

def getlen(a, b, string)
	ary = string.split("")
	return ary.inject(0) { |r, e| r + (e == "a" ? a.length : b.length) }
end

def grabdig(a, b, n, string)
	math = n.divmod(100)
	char = string[math[0]]
	num = char == "a" ? a : b
	return num[math[1] - 1]
end

def getdig(a, b, n, string)
	print "Starting getdig\n"
	string.length.times { |i|
		num = (string[i] == "a" ? a : b)
		if n < num.length
			return num[n - 1]
		else
			n = n - num.length
		end	
	}
	return nil
end

a = "1415926535897932384626433832795028841971693993751058209749445923078164062862089986280348253421170679"
b = "8214808651328230664709384460955058223172535940812848111745028410270193852110555964462294895493038196"

#a = "1415926535"
#b = "8979323846"

#print getlen(a, b, "abbabab")
#print digit(a, b, 35), "\n"

#print fibbo(a, b, 35), " IS THE THING\n"

#print "The digit is: #{digit(a, b, 35)}\n"

phi = (Math.sqrt(5) + 1) / 2
phi = phi**2
result = 0
0.upto(17) { |i|
	print "Cycle #{i}\n"
	#addition = digit(a, b, ((127 + (19 * i)) * 7**i)).to_i * 10**i
	n = ((127 + (19 * i)) * 7**i)
	term, digit = ((127 + (19 * i)) * 7**i).divmod(100)
	print "Term is: #{term}\nDigit is: #{digit}\n"
	target = ((term / phi).floor * phi).ceil == term ? a : b
	addition = target[digit - 1].to_i * (10**i)
	result = result + addition
}


print result, "\n"
