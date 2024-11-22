-- coolfile.lua

-- Function to print a cool message
local function printCoolMessage()
    print("Hello, Lua World! Stay cool!")
end

-- Function to add two numbers
local function addNumbers(a, b)
    return a + b
end

-- Function to check if a number is even
local function isEven(number)
    return number % 2 == 0
end

-- Main execution
printCoolMessage()

local sum = addNumbers(5, 7)
print("The sum of 5 and 7 is: " .. sum)

local number = 10
if isEven(number) then
    print(number .. " is even.")
else
    print(number .. " is odd.")
end