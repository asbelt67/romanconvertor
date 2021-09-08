def fromRoman(romanNumber)
    
    #check if roman number has valid letters for the 1-3999 range
    validChars = ['I','V', 'X', 'L', 'C', 'D', 'M']
    #for each character in the roman number
    romanNumber.each_char do |i|
        #if the character is not in the valid character list, end with TypeError
        if validChars.include? romanNumber[i] == false
            raise TypeError
        end
    end
    
    #check if roman number is lowercase; if it is, end with TypeError
    if romanNumber.match(/[a-z]/)
        raise TypeError
    end
    
    
    #this method will be used to decide how each character in the roman numeral will be parsed to equal an arabic number
    def numeralValues(romanCharacter)
        if romanCharacter == "I"
            return 1
        end
        if romanCharacter == "V"
            return 5
        end
        if romanCharacter == "X"
            return 10
        end
        if romanCharacter == "L"
            return 50
        end
        if romanCharacter == "C"
            return 100
        end
        if romanCharacter == "D"
            return 500
        end
        if romanCharacter == "M"
            return 1000
        end
    end
    
    #arabicNumber = what will be returned, initializing at 0 and will be added as loop progresses
    arabicNumber = 0
    #romanNumArray = splitting the roman numeral (i.e. MCDXCVIII) into an array ([M,C,D,X,C,V,I,I,I])
    romanNumArray = romanNumber.chars
    #skipNextStep = will be needed to skip a step when character i is smaller than i+1 (i.e. IV, add 5, subtract 1, skip next step)
    skipNextStep = false
    romanNumArray.each_with_index {|element, i|
        #checks if skipNextStep is true (only possible if character 1 is smaller than character 2), swaps skipNextStep back to false to prevent endless loop till end, then skips to next iteration
        if skipNextStep
            skipNextStep = false
            next
        end
        #values are calculated using numeralValues method above and getting the element from the array (i.e. array[0] = M, numeralValues(M) = 1000, value = 1000
        value1 = numeralValues(element)
        #if we are not on the final element of the numeral
        if (i+1) < romanNumArray.length()
            value2 = numeralValues(romanNumArray[i+1])
            #if value1 is bigger or equal to value2 (i.e. MV -- 1000 >= 5)
            if value1 >= value2
                #add value1 to total, then continue to the next step
                arabicNumber = arabicNumber + value1
            #if value1 is smaller than value2 (i.e. IV -- 1 < 5)
            else
                #add value2 to total, then subtract value1 from total (i.e. IX -- total + X (10) - I (1) = total + IX (9)
                arabicNumber = arabicNumber + value2 - value1
                #set skipNextStep to true so same element is not added twice (see above for skipNextStep)
                skipNextStep = true
            end
        #if we are on the final element, just add it to the total
        else
            arabicNumber = arabicNumber + value1
        end
    }

    return arabicNumber
end



def toRoman(arabicNumber)
    
    #check if arabic number is outside 1-3999 range; if it is, end with RangeError
    if arabicNumber < 1 or arabicNumber > 3999
        raise RangeError
    end
    
    #the beginning of the roman number--we start with I and multiply it by the arabic number to make the roman number entirely out of I to begin with
    startRomanString = "I"
    romanNumber = startRomanString * arabicNumber
    
    #with the full roman number written out in Is, the string is now gradually replaced with higher level values
    
    romanNumber.gsub!("IIIII", "V")
    romanNumber.gsub!("IIII", "IV")
    romanNumber.gsub!("VV", "X")
    romanNumber.gsub!("VIV", "IX")
    romanNumber.gsub!("XXXXX", "L")
    romanNumber.gsub!("XXXX", "XL")
    romanNumber.gsub!("LL", "C")
    romanNumber.gsub!("LXL", "XC")
    romanNumber.gsub!("CCCCC", "D")
    romanNumber.gsub!("CCCC", "CD")
    romanNumber.gsub!("DD", "M")
    romanNumber.gsub!("DCD", "CM")
    
    return romanNumber
end
