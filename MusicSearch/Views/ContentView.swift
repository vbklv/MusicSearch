//
//  ContentView.swift
//  MusicSearch
//
//  Created by Vladimir Bakalov on 02/08/2025.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel: SearchViewModel

    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    TextField("Search Music", text: $viewModel.searchText, onCommit: {
                        viewModel.search()
                    })
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()

                    Button(action: {
                        viewModel.search()
                    }) {
                        Text("Search")
                    }
                    .padding(.horizontal, 24)
                    .padding(.vertical, 8)
                    .background(.black)
                    .foregroundColor(.white)
                    .clipShape(Capsule())
                    .padding()
                }
                List(viewModel.tracks) { track in
                    let trackName = track.trackName ?? "Unknown"
                    let trackArtist = track.artistName ?? "Unknown"
                    Text(trackName + " - " + trackArtist)
                }
            }
        }
    }
}

#Preview {
    ContentView(viewModel: SearchViewModel())
}
