//
//  Music.swift
//  Assignment4
//
//  Created by mac on 2/15/20.
//  Copyright © 2020 mac. All rights reserved.
//

import Foundation

class Music{
    var id: Int = musicId
    var name: String = ""
    var artist: String = ""
    var price: Double = 0
    var quantity: Int = 0
    static var musicId:Int = 1
    
    init(){}
    init(name:String, artist: String, price: Double, quantity:Int){
        Music.musicId += 1
        self.name = name
        self.artist = artist
        self.price = price
        self.quantity = quantity
    }
}

var MusicList: Array<Music> = Array()

func AddMusic(){
    while true{
        var name: String = ""
        var artist: String = ""
        var price: Double = 0
        var quantity: Int = 0
        while true{
            print("Music Name: ")
            guard let nameStr:String = readLine(), !nameStr.isEmpty else{
                print("Music name cannot be empty! \n")
                continue
            }
            name = nameStr
            break
        }
        
        while true{
            print("Music Artist: ")
            guard let artistStr:String = readLine(), !artistStr.isEmpty else{
                print("Release Year cannot be empty or Sting! \n")
                continue
            }
            artist = artistStr
            break
        }
        
        while true{
            print("Price: ")
            guard let priceStr:String = readLine(), !priceStr.isEmpty, Double(priceStr) != nil else{
                print("Music price cannot be empty and should be Double!\n")
                continue
            }
            price = Double(priceStr)!
            break
        }
        
        while true{
            print("Quantity: ")
            guard let quantityStr:String = readLine(), !quantityStr.isEmpty, Int(quantityStr) != nil else{
                print("Music Quantity cannot be empty and should be Integer!\n")
                continue
            }
            quantity = Int(quantityStr)!
            break
        }
        let newMusic = Music(name: name, artist: artist, price: price, quantity: quantity)
        MusicList.append(newMusic)
        print("Music created successfully! \n")
//        ViewAllMusics()
        break
    }
}

func UpdateMusicDetails(){
//    ViewAllMusics()
    var targetMusic = Music()
    while true{
        print("Please input the id of music to update: ")
        guard let idStr:String = readLine(), !idStr.isEmpty, Int(idStr) != nil else{
            print("Id cannot be empty and should be Integer! \n")
            continue
        }
        if ExistedMusic(id: Int(idStr)!) == nil {
            print("This Music doesn't exist in system \n")
            continue
        }
        targetMusic = ExistedMusic(id: Int(idStr)!)!
        break
    }
    while true{
        print("Please choose the number of which value you want to change: ")
        print("1. Name 2. Artist 3. Price 4. Quantity")
        guard let option:String = readLine(), !option.isEmpty else{
            print("You need to choose a number \n")
            continue
        }
        switch option{
        case "1":
            print("Name: ")
            guard let nameStr:String = readLine(), !nameStr.isEmpty else{
                print("Name cannot be empty! \n")
                continue
            }
            targetMusic.name = nameStr
            print("Music's name changed to \(targetMusic.name) successfully! \n")
        case "2":
            print("Artist: ")
            guard let artistStr:String = readLine(), !artistStr.isEmpty else{
                print("Artist cannot be empty! \n")
                continue
            }
            targetMusic.artist = artistStr
            print("Music's Artist changed to \(targetMusic.artist) successfully! \n")
        case "3":
            print("Price: ")
            guard let priceStr:String = readLine(), !priceStr.isEmpty, Int(priceStr) != nil else{
                print("Price cannot be empty and should be Double! \n")
                continue
            }
            targetMusic.price = Double(priceStr)!
            print("Music's price changed to \(targetMusic.price) successfully! \n")
        case "4":
            print("Quantity: ")
            guard let quantityStr:String = readLine(), !quantityStr.isEmpty, Int(quantityStr) != nil else{
                print("Quantity cannot be empty! \n")
                continue
            }
            targetMusic.quantity = Int(quantityStr)!
            print("Music's quantity changed to \(targetMusic.quantity) successfully! \n")
        default:
            print("Option\(option) does not exist! \n")
            continue
        }
        break
    }
}

func ViewAllMusics(){
    if MusicList.isEmpty {
        print("No music in the system now! \n")
    }
    else{
        print("-------------------- All Musics are here --------------------")
        for Music in MusicList{
            print("Id: \(Music.id), Name: \(Music.name), Artist: \(Music.artist), Price: \(Music.price), Quantity: \(Music.quantity) \n")
        }
        print("-------------------------------------------------------------")
    }
}

func ViewAvaiMusics(){
    print("-------------------- All Available Musics are here --------------------")
    for Music in MusicList{
        if Music.quantity > 0 {
            print("Id: \(Music.id), Name: \(Music.name), Artist: \(Music.artist), Price: \(Music.price), Quantity: \(Music.quantity)\n")
        }
    }
    print("-----------------------------------------------------------------------")
}

func SearchMusic() {
    while true {
        print("Please choose which you want to search by: ")
        print("1. id 2. Name 3. Artist")
        guard let option:String = readLine(), !option.isEmpty else{
            print("You need to choose a number \n")
            continue
        }
        switch option{
        case "1":
            print("id: ")
            guard let idStr:String = readLine(), !idStr.isEmpty, Int(idStr) != nil else{
                print("Id cannot be empty and should be Integer! \n")
                continue
            }
            let music = ExistedMusic(id: Int(idStr)!)
            if music == nil {
                print("This Music doesn't exist in system \n")
                continue
            }
            print("Id: \(music!.id), Name: \(music!.name), Artist: \(music!.artist), Price: \(music!.price), Quantity: \(music!.quantity)\n")
        case "2":
            print("Name: ")
            guard let nameStr:String = readLine(), !nameStr.isEmpty else{
                print("Name cannot be empty! \n")
                continue
            }
            for music in MusicList {
                if music.name == nameStr {
                    print("Id: \(music.id), Name: \(music.name), Artist: \(music.artist), Price: \(music.price), Quantity: \(music.quantity)\n")
                }
            }
        case "3":
            print("Artist: ")
            guard let artistStr:String = readLine(), !artistStr.isEmpty else{
                print("Artist cannot be empty! \n")
                continue
            }
            for music in MusicList {
                if music.artist == artistStr {
                    print("Id: \(music.id), Name: \(music.name), Artist: \(music.artist), Price: \(music.price), Quantity: \(music.quantity)\n")
                }
            }
        default:
            print("Option\(option) does not exist! \n")
            continue
        }
        break
    }
}

func ExistedMusic(id: Int) -> Music?{
    for Music in MusicList{
        if Music.id == id{
            return Music
        }
    }
    return nil
}
