//
//  ContactListView.swift
//  TestTechnique
//
//  Created by Rayan MEHDI on 06/08/2024.
//

import SwiftUI
import Swinject

struct ContactListView: View {
    @EnvironmentObject var router: Router
    
    @StateObject var vm: ContactListViewModel = AppEnvironment.default.assembler.resolver.resolve(ContactListViewModel.self)!
    
    @State private var lastDragPosition: CGFloat = 0.0
    
    var body: some View {
        VStack{
            Text("Contacts")
                .font(.largeTitle)
                .padding([.top, .leading], 16)
            if vm.isLoading && vm.contacts.isEmpty{
                Spacer()
                LoaderView()
                Spacer()
                
            } else {
                contactList
            }
        }.onAsyncViewDidLoad {
            do{
                try await vm.getContacts(results: 10, page: vm.page)
            } catch {
                print(error)
            }
        }
        
    }
    
    var contactList: some View {
        ScrollView(){
            LazyVStack(alignment: .leading){
                ForEach(vm.contacts.indices, id: \.self) { index in
                    let contact = vm.contacts[index]
                    ContactListItem(contact: contact)
                        .onTapGesture {
                            router.push(.detail(contact: contact))
                        }.onAppear {
                            if contact == vm.contacts.last {
                                Task {
                                    await vm.loadMoreContacts()
                                }
                            }
                        }
                }
                if vm.isLoading {
                    LoaderView()
                }
                
            }.alert(isPresented: .constant(vm.error != nil), error: vm.error) { error in
                Button("OK") {
                    vm.error = nil // Reset the error after the alert is dismissed
                }
            } message: { error in
                Text(error.localizedDescription)
            }
        }
    }
}

#Preview {
    ContactListView()
}
