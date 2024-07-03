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

func diceSum (rolledNumbers:Array<Int>)-> Int
{
    var sum = 0
    for i in 0..<rolledNumbers.count
    {
        sum += rolledNumbers[i]
    }
    return sum
}

func readNum()->Int
{
    var isWrong: Bool = false
    var rightNum = 0
    while(isWrong == false)
    {
        print("How much you want to bet?")
        var betNum = Int(readLine()!)
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
        print("The house has $\(houseCost)")
        print("The player has $\(playerFund)")
        print("Round \(round):")
        
        
        var betNum = readNum()
        
        print("You have bet $\(betNum)")
        playerBet()
        
        var rolledNumbers = randomDice(givenNumber: diceNumbers)
        print("The dices are: \(rolledNumbers[0]) \(rolledNumbers[1]) \(rolledNumbers[2])")
        var sum = diceSum(rolledNumbers: rolledNumbers)
        print("The sum of 3 dices are \(sum)")
        if(isBig == true)
        {
            
        }
        isContinue = false
    }
}

diceGame(houseCost: house, playerFund: player)
