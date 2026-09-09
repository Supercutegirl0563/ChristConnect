//
//  Home.swift
//  Announcer
//
//  Created by Alvin Phyo Htet on 10/8/26.
//

import SwiftUI

// MARK: - Data Models

struct Announcement: Identifiable {
    let id = UUID()
    let title: String
    let body: String
    let category: AnnouncementCategory
    let date: Date
    let author: String
    let isPinned: Bool
    let isRead: Bool
    let imageURL: String?
}

enum AnnouncementCategory: String, CaseIterable {
    case all = "All"
    case academic = "Academic"
    case events = "Events"
    case sports = "Sports"
    case cca = "CCA"
    case general = "General"
    case urgent = "Urgent"

    var color: Color {
        switch self {
        case .all: return .blue
        case .academic: return .purple
        case .events: return .orange
        case .sports: return .green
        case .cca: return .pink
        case .general: return .gray
        case .urgent: return .red
        }
    }

    var icon: String {
        switch self {
        case .all: return "rectangle.stack.fill"
        case .academic: return "book.fill"
        case .events: return "calendar"
        case .sports: return "sportscourt.fill"
        case .cca: return "person.3.fill"
        case .general: return "megaphone.fill"
        case .urgent: return "exclamationmark.triangle.fill"
        }
    }
}

struct SchoolEvent: Identifiable {
    let id = UUID()
    let title: String
    let date: Date
    let location: String
    let category: String
    var color: Color
}

struct QuickAccessItem: Identifiable {
    let id = UUID()
    let title: String
    let icon: String
    let color: Color
    let destination: String
}

// MARK: - Home View

struct Home: View {

    @State private var username = "Alvin"
    @State private var searchText = ""
    @State private var selectedCategory: AnnouncementCategory = .all
    @State private var showAllAnnouncements = false

    private let greeting: String = {
        let hour = Calendar.current.component(.hour, from: Date())
        switch hour {
        case 5..<12: return "Good morning"
        case 12..<17: return "Good afternoon"
        case 17..<21: return "Good evening"
        default: return "Good night"
        }
    }()

    private let sampleAnnouncements: [Announcement] = [
        Announcement(
            title: "Mid-Term Examination Schedule Released",
            body: "The mid-term examination schedule for all levels has been posted. Please check the academic portal for your individual timetables.",
            category: .academic,
            date: Calendar.current.date(byAdding: .hour, value: -2, to: Date())!,
            author: "Academic Office",
            isPinned: true,
            isRead: false,
            imageURL: nil
        ),
        Announcement(
            title: "Annual Sports Day 2026",
            body: "This year's Sports Day will be held on 25 September at the National Stadium. All students are required to participate. Registration closes on 15 September.",
            category: .sports,
            date: Calendar.current.date(byAdding: .hour, value: -5, to: Date())!,
            author: "PE Department",
            isPinned: true,
            isRead: false,
            imageURL: nil
        ),
        Announcement(
            title: "CCFA Auditions Open",
            body: "Auditions for the Chinese Cultural and Fine Arts Association drama production are now open. Sign up at the CCA office by Friday.",
            category: .cca,
            date: Calendar.current.date(byAdding: .day, value: -1, to: Date())!,
            author: "CCA Board",
            isPinned: false,
            isRead: true,
            imageURL: nil
        ),
        Announcement(
            title: "School Library Extended Hours",
            body: "The library will remain open until 6 PM during the examination period starting next week. Additional study spaces have been set up on Level 3.",
            category: .general,
            date: Calendar.current.date(byAdding: .day, value: -1, to: Date())!,
            author: "Library",
            isPinned: false,
            isRead: true,
            imageURL: nil
        ),
        Announcement(
            title: "Student Leadership Applications Open",
            body: "Applications for Student Council, Class Monitors, and Prefect positions are now open. Submit your applications through the portal before 20 September.",
            category: .academic,
            date: Calendar.current.date(byAdding: .day, value: -2, to: Date())!,
            author: "Student Affairs",
            isPinned: false,
            isRead: false,
            imageURL: nil
        ),
        Announcement(
            title: "Water Outage - Block C",
            body: "There will be a scheduled water outage in Block C on Wednesday from 10 AM to 2 PM for pipe maintenance. Plan accordingly.",
            category: .urgent,
            date: Calendar.current.date(byAdding: .day, value: -3, to: Date())!,
            author: "Admin Office",
            isPinned: false,
            isRead: true,
            imageURL: nil
        ),
        Announcement(
            title: "Inter-Class Football Tournament Results",
            body: "Congratulations to 4 Sapphire for winning the inter-class football tournament! Final score: 3-1 against 4 Pearl. Well played to all participants.",
            category: .sports,
            date: Calendar.current.date(byAdding: .day, value: -4, to: Date())!,
            author: "Sports Council",
            isPinned: false,
            isRead: true,
            imageURL: nil
        )
    ]

    private let sampleEvents: [SchoolEvent] = [
        SchoolEvent(title: "Mid-Term Break", date: Calendar.current.date(byAdding: .day, value: 7, to: Date())!, location: "School", category: "Holiday", color: .blue),
        SchoolEvent(title: "Career Guidance Talk", date: Calendar.current.date(byAdding: .day, value: 10, to: Date())!, location: "Auditorium", category: "Academic", color: .purple),
        SchoolEvent(title: "Inter-Class Volleyball", date: Calendar.current.date(byAdding: .day, value: 3, to: Date())!, location: "Sports Hall", category: "Sports", color: .green),
        SchoolEvent(title: "Teachers' Day", date: Calendar.current.date(byAdding: .day, value: 14, to: Date())!, location: "School Hall", category: "Event", color: .orange),
    ]

    private let quickAccessItems: [QuickAccessItem] = [
        QuickAccessItem(title: "Timetable", icon: "calendar", color: .blue, destination: "timetable"),
        QuickAccessItem(title: "Applications", icon: "doc.plaintext.fill", color: .purple, destination: "applications"),
        QuickAccessItem(title: "Events", icon: "party.popper.fill", color: .orange, destination: "events"),
        QuickAccessItem(title: "Results", icon: "chart.bar.fill", color: .green, destination: "results"),
        QuickAccessItem(title: "Directory", icon: "person.2.fill", color: .pink, destination: "directory"),
        QuickAccessItem(title: "Feedback", icon: "bubble.left.fill", color: .teal, destination: "feedback"),
    ]

    var filteredAnnouncements: [Announcement] {
        if selectedCategory == .all {
            return sampleAnnouncements
        }
        return sampleAnnouncements.filter { $0.category == selectedCategory }
    }

    var pinnedAnnouncements: [Announcement] {
        filteredAnnouncements.filter { $0.isPinned }
    }

    var regularAnnouncements: [Announcement] {
        filteredAnnouncements.filter { !$0.isPinned }
    }

    var body: some View {
        NavigationStack {
            ZStack {
                Color(white: 0.95)
                    .ignoresSafeArea()

                ScrollView(.vertical, showsIndicators: false) {
                    VStack(alignment: .leading, spacing: 24) {

                        // MARK: - Header
                        headerSection

                        // MARK: - Search Bar
                        searchBar

                        // MARK: - Category Filters
                        categoryFilters

                        // MARK: - Pinned Announcement
                        if !pinnedAnnouncements.isEmpty {
                            pinnedSection
                        }

                        // MARK: - Quick Access
                        quickAccessSection

                        // MARK: - Recent Announcements
                        recentAnnouncementsSection

                        // MARK: - Upcoming Events
                        upcomingEventsSection

                        Spacer(minLength: 20)
                    }
                    .padding(.horizontal)
                }
            }
            .navigationBarHidden(true)
        }
    }

    // MARK: - Header Section

    private var headerSection: some View {
        VStack(alignment: .leading, spacing: 4) {
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text("\(greeting),")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                    Text(username)
                        .font(.largeTitle)
                        .bold()
                }
                Spacer()
                ZStack {
                    Circle()
                        .fill(Color.blue.opacity(0.1))
                        .frame(width: 48, height: 48)
                    Image(systemName: "bell.fill")
                        .foregroundColor(.blue)
                        .font(.title3)
                    // Notification badge
                    Circle()
                        .fill(.red)
                        .frame(width: 10, height: 10)
                        .offset(x: 14, y: -14)
                }
            }
            Text("Welcome back to ChristConnect")
                .font(.subheadline)
                .foregroundColor(.secondary)
        }
        .padding(.top, 8)
    }

    // MARK: - Search Bar

    private var searchBar: some View {
        HStack(spacing: 10) {
            Image(systemName: "magnifyingglass")
                .foregroundColor(.secondary)
            TextField("Search announcements...", text: $searchText)
                .font(.subheadline)
            if !searchText.isEmpty {
                Button(action: { searchText = "" }) {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundColor(.secondary)
                }
            }
        }
        .padding(12)
        .background(Color.white)
        .cornerRadius(14)
        .shadow(color: .black.opacity(0.04), radius: 4, y: 2)
    }

    // MARK: - Category Filters

    private var categoryFilters: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 10) {
                ForEach(AnnouncementCategory.allCases, id: \.self) { category in
                    CategoryPill(
                        title: category.rawValue,
                        icon: category.icon,
                        color: category.color,
                        isSelected: selectedCategory == category
                    ) {
                        withAnimation(.easeInOut(duration: 0.2)) {
                            selectedCategory = category
                        }
                    }
                }
            }
        }
    }

    // MARK: - Pinned Section

    private var pinnedSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Image(systemName: "pin.fill")
                    .foregroundColor(.orange)
                    .font(.caption)
                Text("Pinned")
                    .font(.caption)
                    .foregroundColor(.secondary)
                    .bold()
            }
            ForEach(pinnedAnnouncements) { announcement in
                AnnouncementCard(announcement: announcement)
            }
        }
    }

    // MARK: - Quick Access Section

    private var quickAccessSection: some View {
        VStack(alignment: .leading, spacing: 14) {
            Text("Quick Access")
                .font(.title3)
                .bold()

            LazyVGrid(columns: [
                GridItem(.flexible(), spacing: 12),
                GridItem(.flexible(), spacing: 12),
                GridItem(.flexible(), spacing: 12)
            ], spacing: 12) {
                ForEach(quickAccessItems) { item in
                    QuickAccessCard(item: item)
                }
            }
        }
    }

    // MARK: - Recent Announcements Section

    private var recentAnnouncementsSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Text("Recent Announcements")
                    .font(.title3)
                    .bold()
                Spacer()
                Button("See All") {
                    showAllAnnouncements = true
                }
                .font(.subheadline)
                .foregroundColor(.blue)
            }

            ForEach(regularAnnouncements) { announcement in
                AnnouncementCard(announcement: announcement)
            }
        }
    }

    // MARK: - Upcoming Events Section

    private var upcomingEventsSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Text("Upcoming Events")
                    .font(.title3)
                    .bold()
                Spacer()
                Button("View All") {}
                    .font(.subheadline)
                    .foregroundColor(.blue)
            }

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 14) {
                    ForEach(sampleEvents) { event in
                        EventCard(event: event)
                    }
                }
            }
        }
    }
}

// MARK: - Category Pill

struct CategoryPill: View {
    let title: String
    let icon: String
    let color: Color
    let isSelected: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack(spacing: 6) {
                Image(systemName: icon)
                    .font(.caption2)
                Text(title)
                    .font(.caption)
                    .bold()
            }
            .padding(.horizontal, 14)
            .padding(.vertical, 10)
            .background(isSelected ? color : Color.white)
            .foregroundColor(isSelected ? .white : .primary)
            .cornerRadius(20)
            .shadow(color: isSelected ? color.opacity(0.3) : .black.opacity(0.05), radius: 4, y: 2)
        }
    }
}

// MARK: - Announcement Card

struct AnnouncementCard: View {
    let announcement: Announcement

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack(alignment: .top, spacing: 10) {
                // Category icon
                ZStack {
                    RoundedRectangle(cornerRadius: 8)
                        .fill(announcement.category.color.opacity(0.15))
                        .frame(width: 36, height: 36)
                    Image(systemName: announcement.category.icon)
                        .font(.system(size: 14))
                        .foregroundColor(announcement.category.color)
                }

                VStack(alignment: .leading, spacing: 4) {
                    HStack {
                        Text(announcement.title)
                            .font(.subheadline)
                            .bold()
                            .lineLimit(2)
                        Spacer()
                        if !announcement.isRead {
                            Circle()
                                .fill(.blue)
                                .frame(width: 8, height: 8)
                        }
                    }
                    Text(announcement.body)
                        .font(.caption)
                        .foregroundColor(.secondary)
                        .lineLimit(2)
                }
            }

            // Footer
            HStack {
                Text(announcement.category.rawValue)
                    .font(.caption2)
                    .bold()
                    .padding(.horizontal, 8)
                    .padding(.vertical, 3)
                    .background(announcement.category.color.opacity(0.12))
                    .foregroundColor(announcement.category.color)
                    .cornerRadius(6)

                Text(announcement.author)
                    .font(.caption2)
                    .foregroundColor(.secondary)

                Spacer()

                Text(announcement.date.formatted(.relative(presentation: .named)))
                    .font(.caption2)
                    .foregroundColor(.secondary)
            }
        }
        .padding(14)
        .background(Color.white)
        .cornerRadius(16)
        .shadow(color: .black.opacity(0.05), radius: 6, y: 2)
    }
}

// MARK: - Quick Access Card

struct QuickAccessCard: View {
    let item: QuickAccessItem

    var body: some View {
        VStack(spacing: 8) {
            ZStack {
                RoundedRectangle(cornerRadius: 14)
                    .fill(item.color.opacity(0.12))
                    .frame(width: 44, height: 44)
                Image(systemName: item.icon)
                    .font(.title3)
                    .foregroundColor(item.color)
            }
            Text(item.title)
                .font(.caption)
                .bold()
                .foregroundColor(.primary)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 14)
        .background(Color.white)
        .cornerRadius(16)
        .shadow(color: .black.opacity(0.05), radius: 4, y: 2)
    }
}

// MARK: - Event Card

struct EventCard: View {
    let event: SchoolEvent

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            // Date badge
            HStack(spacing: 4) {
                Text(event.date.formatted(.dateTime.day().month(.abbreviated)))
                    .font(.caption2)
                    .bold()
            }
            .padding(.horizontal, 8)
            .padding(.vertical, 4)
            .background(event.color.opacity(0.15))
            .foregroundColor(event.color)
            .cornerRadius(6)

            Text(event.title)
                .font(.subheadline)
                .bold()
                .lineLimit(2)

            HStack(spacing: 4) {
                Image(systemName: "mappin")
                    .font(.caption2)
                    .foregroundColor(.secondary)
                Text(event.location)
                    .font(.caption2)
                    .foregroundColor(.secondary)
            }

            Text(event.category)
                .font(.caption2)
                .bold()
                .padding(.horizontal, 8)
                .padding(.vertical, 3)
                .background(event.color.opacity(0.12))
                .foregroundColor(event.color)
                .cornerRadius(6)
        }
        .padding(14)
        .frame(width: 160)
        .background(Color.white)
        .cornerRadius(16)
        .shadow(color: .black.opacity(0.05), radius: 4, y: 2)
    }
}

// MARK: - Preview

#Preview {
    Home()
}
