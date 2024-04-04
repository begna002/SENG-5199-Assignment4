//
//  MadLibView.swift
//  SENG-5199-Assignment4
//
//  Created by Moti Begna on 3/29/24.
//

import Foundation
import SwiftUI

struct MadLibView: View {
    @State var madLibResponseList: [MadLibResponse]? = nil

    var body: some View {
        VStack(alignment: .leading) {                                               
            if let madLibResponseList {
                NavigationSplitView {
                    List {
                        ForEach(madLibResponseList) { madLib in
                            NavigationLink {
                                MadLibQuestionView(id: madLib.id)
                            } label: {
                                Text(madLib.storyTitle)
                            }
                        }
                    }
                    .navigationTitle("MadLibs")
                } detail: {
                    Text("All Madlibs")
                }
            } else {
                LoadingIndicator()
            }
        }
        .task {
            getAllMadLibs(completion: {msg in madLibResponseList = msg})
        }
    }
}


#Preview {
    MadLibView()
}
