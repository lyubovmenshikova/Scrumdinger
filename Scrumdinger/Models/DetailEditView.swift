//
//  DetailEditView.swift
//  Scrumdinger
//
//  Created by Lyubov Menshikova on 06.07.2022.
//

import SwiftUI

struct DetailEditView: View {
    
    @State private var data = DailyScrum.Data()
    @State private var newAttendeeName = ""
    
    var body: some View {
        Form {
            Section(header: Text("Meeting Info")) {
                TextField("Title", text: $data.title)
                HStack {
                    Slider(value: $data.lenghtInMinutes, in: 5...30, step: 1) {
                        Text("Lenght")
                    }
                    .accessibilityValue("\(Int(data.lenghtInMinutes)) minutes")
                    Spacer()
                    Text("\(Int(data.lenghtInMinutes)) minutes")
                        .accessibilityHidden(true)
                }
            }
            Section(header: Text("Attendees")) {
                ForEach(data.attendees) { attendee in
                    Text(attendee.name)
                }
                .onDelete { indices in
                    data.attendees.remove(atOffsets: indices)
                }
                HStack {
                    TextField("New Attendee", text: $newAttendeeName)
                    Button(action: {
                        withAnimation {
                            let attendee = DailyScrum.Attendee(name: newAttendeeName)
                            data.attendees.append(attendee)
                            newAttendeeName = ""
                        }
                    }) {
                        Image(systemName: "plus.circle.fill")
                            .accessibilityLabel("Add attendee")
                    }
                    .disabled(newAttendeeName.isEmpty)
                }
            }
        }
    }
}

struct DetailEditView_Previews: PreviewProvider {
    static var previews: some View {
        DetailEditView()
    }
}
