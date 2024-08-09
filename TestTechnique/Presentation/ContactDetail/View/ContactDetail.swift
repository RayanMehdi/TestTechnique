//
//  ContactDetail.swift
//  TestTechnique
//
//  Created by Rayan MEHDI on 07/08/2024.
//

import SwiftUI
import MapKit

struct ContactDetail: View {
    let contact: ContactEntity
    var body: some View {
        ScrollView{
            VStack{
                AsyncImage(url: URL(string: contact.picture.large)) { image in
                    image.resizable()
                } placeholder: {
                    ProgressView()
                }
                .frame(width: 100 , height: 100)
                .clipShape(Circle())
                Text(contact.name.displayName)
                    .font(.headline)
                Text(contact.email)
                    .font(.subheadline)
                    .foregroundColor(.gray)
                Spacer()
                VStack(alignment:.leading) {
                    HStack{
                        Text("Phone:")
                            .font(.subheadline)
                        Text(contact.phone)
                        Spacer()
                    }.padding([.leading, .trailing])
                }
                HStack(alignment: .top){
                    Text("Address:")
                        .font(.subheadline)
                    Text(contact.location.displayableAddress)
                    Spacer()
                }.padding([.leading, .trailing])
            }
        }
    }
}

#Preview {
    ContactDetail(contact: ContactEntity.init(gender: "k,zaedd", name: Name(title: "Ms", first: "Jane", last: "Doe"), location: Location(
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
