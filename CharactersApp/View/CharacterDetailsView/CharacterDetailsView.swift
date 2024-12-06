//
//  CharacterDetailsView.swift
//  CharactersApp
//
//  Created by Sarah Gamal on 30/11/2024.
//

import SwiftUI

struct CharacterDetailsView: View {
    let character: Character
    
    var body: some View {
        GeometryReader { proxy in
            VStack(alignment: .leading, spacing: 20) {
                ZStack(alignment: .topLeading) {
                    
                    AsyncImage(url: URL(string:character.image)){ phase in
                        switch phase {
                        case .empty:
                            ProgressView()
                        case .success(let image):
                            image
                                .resizable()
                                .scaledToFill()
                                .frame(width: proxy.size.width,
                                       height: proxy.size.height * 0.48)
                                .cornerRadius(32)
                        case .failure(_):
                            Image("placeholder")
                        @unknown default:
                            Image("placeholder")
                        }
                    }
                 
                    BackButtonView()
                        .padding(.leading, 24)
                        .padding(.top, 68)
                }
                HStack(alignment: .top) {
                    VStack(alignment: .leading, spacing: 4) {
                        Text(character.name)
                            .font(.custom("Avenir-Heavy", size: 20))
                        
                        HStack(alignment: .firstTextBaseline, spacing: 10) {
                            Text(character.species)
                                .font(.custom("Avenir-Medium", size: 17))

                            
                            Circle()
                                .fill(Color.black)
                                .frame(width: 5, height: 5)
                            
                            Text(character.gender)
                                .font(.custom("Avenir-Medium", size: 17))
                                .foregroundColor(.black.opacity(0.5))

                        }
                    }
                    .padding(.top, 4)
                    
                    Spacer()
                    
                    Text(character.status)
                        .font(.custom("Avenir-Medium", size: 14))
                        .foregroundColor(.black)
                        .padding(.horizontal, 8)
                        .padding(.vertical, 4)
                        .background(
                            Capsule()
                                .fill(Color(red: 105/255, green: 201/255, blue: 239/255))
                        )
                }
                .padding([.leading, .trailing], 24)
                
                HStack {
                    Text("Location : ")
                        .font(.custom("Avenir-Heavy", size: 17))

                    Text(character.location.name)
                        .font(.custom("Avenir-Medium", size: 17))
                        .foregroundColor(.black.opacity(0.7))

                }
                .padding(.leading, 24)

                Spacer()
                
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarHidden(true)
            .navigationViewStyle(StackNavigationViewStyle())
        }
        .edgesIgnoringSafeArea(.top)
        
    }
}


// Preview Section
struct CharacterDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        // Mock Character Object
        let mockCharacter = Character(
            id: 1,
            name: "Zephyr",
            status: "Status",
            species: "Elf",
            gender: "Male",
            image: "https://via.placeholder.com/150",
            location: Location(name: "Citadel of Ricks", url: "")
        )
        
        CharacterDetailsView(character: mockCharacter)
    }
}
