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
        NavigationStack {
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
                
                if let error = viewModel.errorMessage {
                    Text(error)
                        .foregroundColor(.red)
                        .task {
                            try? await Task.sleep(nanoseconds: 700_000_000)
                            viewModel.errorMessage = ""
                        }
                }

                if viewModel.isLoading && viewModel.tracks.isEmpty {
                    ProgressView()
                }

                List(viewModel.tracks) { track in
                    TrackRow(track: track)
                }
                .listStyle(.plain)
            }
        }
        .navigationTitle("iTunes Search")
    }
}

struct TrackRow: View {
    var track: Track

    var body: some View {
        HStack(alignment: .top) {
            if let arworkUrl = track.artworkUrl100, let url = URL(string: arworkUrl) {
                AsyncImage(url: url) { image in
                    image
                } placeholder: {
                    ProgressView()
                }
                .frame(width: 80, height: 80)
                .cornerRadius(8)
            }

            VStack(alignment: .leading) {
                Text(track.artistName ?? "Unknown Artist")
                    .font(.headline)
                Text(track.trackName ?? "Unknown Track")
                    .font(.title3)
                if let description = track.collectionName {
                    Text(description)
                        .font(.caption)
                        .lineLimit(2)
                }
                if let releaseDateString = track.releaseDate, let releaseDateStringFormatted = ISO8601DateFormatter().date(
                    from: releaseDateString
                ) {
                    Text(releaseDateStringFormatted, style: .date)
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
            }
        }
        .padding(.vertical, 4)
    }
}

#Preview {
    ContentView(viewModel: SearchViewModel())
}
