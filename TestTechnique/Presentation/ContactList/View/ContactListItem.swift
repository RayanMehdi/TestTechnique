//
//  ContactListItem.swift
//  TestTechnique
//
//  Created by Rayan MEHDI on 06/08/2024.
//

import Foundation
import SwiftUI

struct ContactListItem: View {
    let contact: ContactEntity
    
    var body: some View {
        HStack {
            AsyncImage(url: URL(string: contact.picture.thumbnail)) { image in
                image.resizable()
            } placeholder: {
                ProgressView()
            }
            .frame(width: 50, height: 50)
            .clipShape(Circle())
            
            VStack(alignment: .leading) {
                Text(contact.name.displayName)
                    .font(.headline)
                Text(contact.email)
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
            Spacer()
        }.padding([.leading, .trailing])
    }
}

#Preview {
    ContactListItem(contact: ContactEntity.init(gender: "k,zaedd", name: Name(title: "Ms", first: "Jane", last: "Doe"), location: Location(
        street: Location.Street(number: 123, name: "Main Street"),
        city: "Somewhere",
        state: "Some State",
        country: "Some Country",
        postcode: .stringPostcode("12345"),
        coordinates: Location.Coordinates(latitude: "0.0", longitude: "0.0"),
        timezone: Location.Timezone(offset: "+0:00", description: "GMT")
    ),
                                              email: "oijazef", phone: "lizac",
                                              picture: Picture(
        large: "https://randomuser.me/api/portraits/women/1.jpg",
        medium: "https://randomuser.me/api/portraits/med/women/1.jpg",
        thumbnail: "https://randomuser.me/api/portraits/thumb/women/1.jpg"
    )))
}
