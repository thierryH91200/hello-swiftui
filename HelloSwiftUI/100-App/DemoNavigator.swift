//
//  DemoNavigator.swift
//  HelloSwiftUI
//
//  Created by Kyuhyun Park on 9/17/24.
//

import SwiftUI

struct DemoNavigator: View {

    struct Demo: Identifiable, Hashable, IDHashable {
        let id = UUID()
        let label: String
        let view: AnyView
    }

    struct DemoSection: Identifiable, Hashable, IDHashable {
        let id = UUID()
        let label: String
        let demoList: [Demo]
    }

    static let demoSections = [
        DemoSection(
            label: "Scene",
            demoList: [
                Demo(label: "Window", view: AnyView(WindowDemo())),
                Demo(label: "WindowGroup", view: AnyView(WindowGroupDemo())),
                Demo(label: "DocumentGroup", view: AnyView(DocumentGroupDemo())),
            ]
        ),
        DemoSection(
            label: "Navigation",
            demoList: [
                Demo(label: "NavigationSplitView", view: AnyView(NavigationSplitViewDemoPlaceholder())),
                Demo(label: "TabView", view: AnyView(TabViewDemo())),
            ]
        ),
        DemoSection(
            label: "Modal",
            demoList: [
                Demo(label: "ModalDemo", view: AnyView(ModalDemo())),
            ]
        ),
        DemoSection(
            label: "Model data",
            demoList: [
                Demo(label: "State", view: AnyView(StateDemo())),
                Demo(label: "StateAnimation", view: AnyView(StateAnimationDemo())),
                Demo(label: "Observable", view: AnyView(ObservableDemo())),
                Demo(label: "ObservableObject", view: AnyView(ObservableObjectDemo())),
                Demo(label: "SceneObject", view: AnyView(SceneStorageDemo())),
                Demo(label: "ViewID", view: AnyView(ViewIDDemo())),
            ]
        ),
        DemoSection(
            label: "View",
            demoList: [
                Demo(label: "Text", view: AnyView(TextDemo())),
                Demo(label: "TextField", view: AnyView(TextFieldDemo())),
                Demo(label: "Button", view: AnyView(ButtonDemo())),
                Demo(label: "Link", view: AnyView(LinkDemo())),
                Demo(label: "Menu", view: AnyView(MenuDemo())),
                Demo(label: "DatePicker", view: AnyView(DatePickerDemo())),
            ]
        ),
        DemoSection(
            label: "Command",
            demoList: [
                Demo(label: "Command", view: AnyView(CommandDemo())),
                Demo(label: "Context Menu", view: AnyView(ContextMenuDemo())),
            ]
        ),
        DemoSection(
            label: "Form",
            demoList: [
                Demo(label: "Form", view: AnyView(FormDemo())),
            ]
        ),
        DemoSection(
            label: "Grouping",
            demoList: [
                Demo(label: "Group", view: AnyView(GroupDemo())),
                Demo(label: "Section", view: AnyView(SectionDemo())),
                Demo(label: "GroupBox", view: AnyView(GroupBoxDemo())),
            ]
        ),
        DemoSection(
            label: "List",
            demoList: [
                Demo(label: "List Simple", view: AnyView(ListSimple())),
                Demo(label: "List Loop", view: AnyView(ListLoop())),
                Demo(label: "List Section", view: AnyView(ListSection())),
                Demo(label: "List Hierarchical", view: AnyView(ListHierarchical())),
                Demo(label: "List Styles", view: AnyView(ListStyles())),
                Demo(label: "List Edit", view: AnyView(ListEditDemo())),
                Demo(label: "ForEach", view: AnyView(ForEachDemo())),
                Demo(label: "LazyVStack", view: AnyView(LazyVStackDemo())),
            ]
        ),
        DemoSection(
            label: "Custom List",
            demoList: [
                Demo(label: "Custom List", view: AnyView(CustomListDemo())),
            ]
        ),
        DemoSection(
            label: "Grid",
            demoList: [
                Demo(label: "GridView", view: AnyView(GridViewDemo())),
                Demo(label: "GridViewDivider", view: AnyView(GridViewDividerDemo())),
                Demo(label: "LazyGridView", view: AnyView(LazyGridViewDemo())),
                Demo(label: "LazyGridView2", view: AnyView(LazyGridViewDemo2())),
            ]
        ),
        DemoSection(
            label: "Table",
            demoList: [
                Demo(label: "Table", view: AnyView(TableDemo())),
                Demo(label: "Outline", view: AnyView(OutlineViewDemo())),
                Demo(label: "Outline Col", view: AnyView(OutlineViewWithColumnsDemo()))
            ]
        ),
        DemoSection(
            label: "AppKit",
            demoList: [
                Demo(label: "NSViewRepresentable", view: AnyView(NSViewRepresentableDemo())),
                Demo(label: "Coordinator", view: AnyView(NSViewRepresentableCoordinatorDemo())),
                Demo(label: "NSViewControllerRepresentable", view: AnyView(NSViewControllerRepresentableDemo())),
            ]
        ),
        DemoSection(
            label: "Task",
            demoList: [
                Demo(label: "Task", view: AnyView(TaskDemo())),
            ]
        ),
        DemoSection(
            label: "Combine",
            demoList: [
                Demo(label: "Combine", view: AnyView(CombineDemo())),
                Demo(label: "SignUpForm", view: AnyView(SignUpForm())),
            ]
        ),
    ]

    @State var selectedSection = Self.demoSections[11]
    @State var selectedDemo = Self.demoSections[11].demoList[2]

    @State var searchText = ""

    @State var isExpanded = true

    var body: some View {
        NavigationSplitView {
            List(selection: $selectedSection) {
                ForEach(Self.demoSections) { section in
                    NavigationLink(section.label, value: section)
                }
                Section {
                    Text("Badge")
                        .badge(36)
                }
                Section("Expandable", isExpanded: $isExpanded) {
                    Text("Item 1")
                    Text("Item 2")
                    Text("Item 3")
                }
            }
            .onChange(of: selectedSection) { oldValue, newValue in
                selectedDemo = newValue.demoList[0]
            }
        } content: {
            List(selectedSection.demoList, selection: $selectedDemo) { demo in
                NavigationLink(demo.label, value: demo)
            }
        } detail: {
            selectedDemo.view
        }
        .toolbar {
            CustomToolbar() // ToolbarDemo
        }
        .searchable(text: $searchText)
    }

}
