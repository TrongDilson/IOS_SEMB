//
//  main.swift
//  TaiXiu
//
//  Created by Trong Tran Vinh on 3/7/24.
//

import Foundation

let diceNumbers = 6// Dice number from 1 to 6
var isContinue: Bool = true
var isBig: Bool = false
var house = 1000
var player = 100

// Function to shuffle dice
func randomDice (givenNumber:Int)-> Array<Int>
{
    var chosenSample = [0, 0, 0]
    for i in 0 ..< 3
    {
        chosenSample[i] = Int.random(in: 1..<(givenNumber + 1))
    }
    return chosenSample
}
//print(randomDice(givenNumber: diceNumbers))

// Function for players to decide continue to play or not
func playerChoice()
{
    var isWrong: Bool = false
    
    while(isWrong == false)
    {
        print("Do you want to continue? press 1 to continue and 0 to end")
        let choice = readLine()
        switch choice
        {
        case "1":
            isContinue = true
            isWrong = true
        case "0":
            isContinue = false
            isWrong = true
        default:
            print("Invalid Input, please try again")
        }
    }
}
//playerChoice()
//print(isContinue)

//Function for player to decide the bet whether big or small
func playerBet()
{
    var isWrong: Bool = false
    
    while(isWrong == false)
    {
        print("Do you want to bet big or small?(big/small)")
        let choice = readLine()
        switch choice?.lowercased()
        {
        case "big":
            isBig = true
            isWrong = true
        case "small":
            isBig = false
            isWrong = true
        default:
            print("Invalid Input, please try again")
        }
    }
}
//playerBet()
//print(isBig)

// Function to sum up total rolled dice numbers
func diceSum (rolledNumbers:Array<Int>)-> Int
{
    var sum = 0
    for i in 0..<rolledNumbers.count
    {
        sum += rolledNumbers[i]
    }
    return sum
}

// Function to read bet number from player
func readNum()->Int
{
    var isWrong: Bool = false
    var rightNum = 0
    while(isWrong == false)
    {
        print("How much you want to bet?")
        let betNum = Int(readLine()!)
        if betNum != nil
        {
            isWrong = true
            rightNum = Int(betNum!)
        } else
        {
            print("This is not number.")
        }
    }
    return rightNum
}

//Main Function to play Tai Xiu
func diceGame (houseCost: Int, playerFund: Int)
{
    print("Try your luck to win all money of the house!")
    var round = 0
    var currHouse = houseCost
    var currPlayer = playerFund
    var isEnough: Bool = false
    
    while(isContinue == true)
    {
        round += 1
        print("The house has $\(currHouse)")
        print("The player has $\(currPlayer)")
        print("Round \(round):")
        var betNum = 0
        
        if (currPlayer == 0)
        {
            print("You are out of money! Good Bye!")
            isContinue = false
        } else if (currHouse == 0)
        {
            print("You have won a house! Congratualtion!")
            isContinue = false
        }else if (round > 1)
        {
            playerChoice()
        }
        
        if(isContinue == true)
        {
            isEnough = false
            while(isEnough == false)
            {
                betNum = readNum()
                if(betNum <= currPlayer)
                {
                    isEnough = true
                } else
                {
                    print("You have bet larger than the amount you have. Please bet again!")
                }
            }
            
            print("You have bet $\(betNum)")
            playerBet()
            
            let rolledNumbers = randomDice(givenNumber: diceNumbers)
            print("The dices are: \(rolledNumbers[0]) \(rolledNumbers[1]) \(rolledNumbers[2])")
            
            if(rolledNumbers[0] == rolledNumbers[1] && rolledNumbers[0] == rolledNumbers[2])
            {
                print("You lost \(betNum) because 3 rolled numbers are equal")
                currPlayer -= betNum
                currHouse += betNum
            } else
            {
                let sum = diceSum(rolledNumbers: rolledNumbers)
                print("The sum of 3 dices are \(sum)")
                
                if(isBig == true)
                {
                    if sum >= 11 && sum <= 17
                    {
                        print("You won \(betNum)")
                        currPlayer += betNum
                        currHouse -= betNum
                    } else
                    {
                        print("You lost \(betNum)")
                        currPlayer -= betNum
                        currHouse += betNum
                    }
                } else
                {
                    if sum >= 4 && sum <= 10
                    {
                        print("You won \(betNum)")
                        currPlayer += betNum
                        currHouse -= betNum
                    } else
                    {
                        print("You lost \(betNum)")
                        currPlayer -= betNum
                        currHouse += betNum
                    }
                }
            }
        } else
        {
            isContinue = false
            print("Thank you for playing")
        }
    }
}

//Main
diceGame(houseCost: house, playerFund: player)
