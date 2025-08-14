//
//  SideMenuList_View.swift
//  IntelliStaff_EMA
//
//  Created by ios on 12/08/25.
//

import SwiftUI

struct SideMenuList_View: View {
 
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
            .contentShape(Rectangle()) // Makes the whole row tappable
            .onTapGesture {
                viewModel.toggleSection(section)
            }
        }
    }



#Preview {
    SideMenuList_View()
}
