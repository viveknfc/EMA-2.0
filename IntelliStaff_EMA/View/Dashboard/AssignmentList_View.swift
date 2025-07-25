//
//  AssignmentList_View.swift
//  IntelliStaff_EMA
//
//  Created by Vivek Lakshmanan on 20/07/25.
//

import SwiftUI

struct AssignmentList_View: View {
    let assignments: [String] = [
        "Math Homework",
        "Science Project",
        "English Essay",
        "History Notes",
        "Chemistry Lab"
    ]
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Today's assignments (\(assignments.count))")
                .font(.titleFont)
                .foregroundColor(.black)

            ScrollView {
                LazyVStack(alignment: .leading, spacing: 10) {
                    ForEach(assignments, id: \.self) { item in
                        Text("• \(item)")
                            .foregroundColor(.gray)
                            .font(.size16RFont)
                    }
                }
            }
        }
        .padding()
    }
}

#Preview {
    AssignmentList_View()
}
