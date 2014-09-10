//
//  WordSort.swift
//  DemoClass
//
//  Created by Dzung Nguyen on 9/10/14.
//  Copyright (c) 2014 Techmaster. All rights reserved.
//

import UIKit
class WordSort: GenericVC {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.wordSort()
        // Do any additional setup after loading the view.
    }
    func wordSort() {
        var string = "I like this. i hate that dog. Cat is fun,joke,love: is it cool?. dog,flower;dog. hate is bad hate.Love is all around. Red blue green yellow violet sexy"
        var arrayRaw = stringToArray(string)
        var arraySort = rawWordArray(arrayRaw)
        var arrayPrint = sortedArray(arraySort)
        for i in arrayPrint {
            self.inRa("\(i.word): \(i.count)")
        }
    }
    
    // Break string in to array
    func stringToArray(string: String) ->[String] {
        let separator = NSMutableCharacterSet(charactersInString: " .?!:;,")
        let array = string.lowercaseString.componentsSeparatedByCharactersInSet(separator)
        return array
    }
    
    // Remove dummy words
    func shouldRemoveThisWord(word: String) -> Bool {
        
        let dummyWords = ["", " ","a", "all", "an", "i", "in", "is", "it", "are", "were", "he", "she", "they", "it's", "my", "his", "her", "their", "this", "that", "very", "much"]
        if contains(dummyWords, word) { return true }
        
        return false
    }
    // Create rawWordArray
    func rawWordArray(array: [String]) ->[Word] {
        var arrayRaw = [Word]()
        for item in array {
            if !shouldRemoveThisWord(item) {
                arrayRaw.append(Word(word: item))
                break
            }
        }
        for item in array {
            if !shouldRemoveThisWord(item) {
                var index: Int = 0
                for i in arrayRaw {
                    if item < i.word {
                        index++
                        if index == arrayRaw.count {
                            arrayRaw.insert(Word(word: item), atIndex: index)
                            index = 0
                            break
                        }
                    } else if item == i.word {
                        index = 0
                        i.count++
                        break
                    } else if item > i.word {
                        arrayRaw.insert(Word(word: item), atIndex: index)
                        index = 0
                        break
                    }
                }
            }
        }
        return arrayRaw
    }
    // Create sorted array
    func sortedArray(array: [Word]) ->[Word] {
        var index: Int = array.count - 1
        print(index)
        for i in 0..<index {
            for j in (i + 1)...index {
                var temp = array[j].count
                var string = array[j].word
                if array[i].count < array[j].count {
                    array[j].word = array[i].word
                    array[i].word = string
                    array[j].count = array[i].count
                    array[i].count = temp
                }
            }
        }
        return array
    }
}
