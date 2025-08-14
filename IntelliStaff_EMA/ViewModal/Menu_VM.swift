//
//  Untitled.swift
//  IntelliStaff_EMA
//
//  Created by ios on 12/08/25.
//

import SwiftUI

struct SectionItem: Identifiable {
    let id = UUID()
    let title: String
    let items: [String]
    var isExpanded: Bool = false
}

class MenuViewModel: ObservableObject {
    @Published var sections: [SectionItem] = [
        SectionItem(title: "Fruits", items: ["Apple", "Banana", "Mango"]),
        SectionItem(title: "Vegetables", items: ["Carrot", "Broccoli", "Lettuce"]),
        SectionItem(title: "Dairy", items: ["Milk", "Cheese", "Yogurt"])
    ]
    
    func toggleSection(_ section: SectionItem) {
        if let index = sections.firstIndex(where: { $0.id == section.id }) {
            sections[index].isExpanded.toggle()
        }
    }
}

struct ExpandableListView: View {
    @StateObject private var viewModel = MenuViewModel()

    var body: some View {
        List {
            ForEach(viewModel.sections) { section in
                Section(header: headerView(for: section)) {
                    if section.isExpanded {
                        ForEach(section.items, id: \.self) { item in
                            Text(item)
                        }
                    }
                }
            }
        }
        .listStyle(InsetGroupedListStyle())
    }
    
    private func headerView(for section: SectionItem) -> some View {
        HStack {
            Text(section.title)
                .font(.headline)
            Spacer()
            Image(systemName: section.isExpanded ? "chevron.down" : "chevron.right")
        }
        .contentShape(Rectangle())
        .onTapGesture {
            viewModel.toggleSection(section)
        }
    }
}
