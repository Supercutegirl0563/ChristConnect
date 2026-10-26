//
//  Settings.swift
//  Announcer
//
//  Created by Alvin Phyo Htet on 10/8/26.
//

import SwiftUI

// MARK: - Settings View

struct Settings: View {

    @State private var displayName = "Alvin"
    @State private var className = "1 Power 1"

    // Notification preferences
    @State private var pushNotifications = true
    @State private var pinnedAlerts = true
    @State private var urgentAlerts = true
    @State private var emailDigest = false

    // Announcement categories
    @State private var enabledCategories: Set<AnnouncementCategory> = Set(AnnouncementCategory.allCases.filter { $0 != .all })

    // Appearance
    @State private var darkMode = false
    @State private var compactCards = false

    var body: some View {
        NavigationStack {
            ZStack {
                Color(white: 0.95)
                    .ignoresSafeArea()

                ScrollView(.vertical, showsIndicators: false) {
                    VStack(alignment: .leading, spacing: 24) {

                        // MARK: - Header
                        headerSection

                        // MARK: - Profile
                        profileSection

                        // MARK: - Notification Preferences
                        notificationSection

                        // MARK: - Announcement Categories
                        categorySection

                        // MARK: - Appearance
                        appearanceSection

                        // MARK: - General
                        generalSection

                        // MARK: - Sign Out
//                        signOutSection

                        // MARK: - Footer
                        footerSection

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
            Text("Settings")
                .font(.largeTitle)
                .bold()
            Text("Manage your ChristConnect preferences")
                .font(.subheadline)
                .foregroundColor(.secondary)
        }
        .padding(.top, 8)
    }

    // MARK: - Profile Section

    private var profileSection: some View {
        Button(action: {}) {
            HStack(spacing: 14) {
                ZStack {
                    Circle()
                        .fill(Color.blue.opacity(0.15))
                        .frame(width: 52, height: 52)
                    Text(String(displayName.prefix(1)))
                        .font(.title3)
                        .bold()
                        .foregroundColor(.blue)
                }

                VStack(alignment: .leading, spacing: 4) {
                    Text(displayName)
                        .font(.subheadline)
                        .bold()
                        .foregroundColor(.primary)
                    Text("\(className) · Student")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }

                Spacer()

                Image(systemName: "chevron.right")
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            .padding(14)
            .background(Color.white)
            .cornerRadius(16)
            .shadow(color: .black.opacity(0.05), radius: 6, y: 2)
        }
    }

    // MARK: - Notification Section

    private var notificationSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            sectionHeader("Notifications")

            VStack(spacing: 0) {
                SettingsToggleRow(
                    icon: "bell.fill",
                    color: .blue,
                    title: "Push Notifications",
                    subtitle: "Get alerts for new announcements",
                    isOn: $pushNotifications
                )

                SettingsDivider()

                SettingsToggleRow(
                    icon: "pin.fill",
                    color: .orange,
                    title: "Pinned Announcements",
                    subtitle: "Always notify about pinned posts",
                    isOn: $pinnedAlerts
                )

                SettingsDivider()

                SettingsToggleRow(
                    icon: "exclamationmark.triangle.fill",
                    color: .red,
                    title: "Urgent Alerts",
                    subtitle: "Critical school notices",
                    isOn: $urgentAlerts
                )

                SettingsDivider()

                SettingsToggleRow(
                    icon: "envelope.fill",
                    color: .purple,
                    title: "Daily Email Digest",
                    subtitle: "A summary every evening",
                    isOn: $emailDigest
                )
            }
            .padding(.vertical, 4)
            .padding(.horizontal, 14)
            .background(Color.white)
            .cornerRadius(16)
            .shadow(color: .black.opacity(0.05), radius: 6, y: 2)
        }
    }

    // MARK: - Category Section

    private var categorySection: some View {
        VStack(alignment: .leading, spacing: 12) {
            VStack(alignment: .leading, spacing: 2) {
                sectionHeader("My Announcements")
                Text("Choose which school announcement categories you follow")
                    .font(.caption)
                    .foregroundColor(.secondary)
            }

            VStack(spacing: 0) {
                ForEach(AnnouncementCategory.allCases.filter { $0 != .all }, id: \.self) { category in
                    SettingsToggleRow(
                        icon: category.icon,
                        color: category.color,
                        title: category.rawValue,
                        isOn: Binding(
                            get: { enabledCategories.contains(category) },
                            set: { isOn in
                                if isOn {
                                    enabledCategories.insert(category)
                                } else {
                                    enabledCategories.remove(category)
                                }
                            }
                        )
                    )

                    if category != AnnouncementCategory.allCases.last {
                        SettingsDivider()
                    }
                }
            }
            .padding(.vertical, 4)
            .padding(.horizontal, 14)
            .background(Color.white)
            .cornerRadius(16)
            .shadow(color: .black.opacity(0.05), radius: 6, y: 2)
        }
    }

    // MARK: - Appearance Section

    private var appearanceSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            sectionHeader("Appearance")

            VStack(spacing: 0) {
                SettingsToggleRow(
                    icon: "moon.fill",
                    color: .indigo,
                    title: "Dark Mode",
                    subtitle: "Easier on the eyes at night",
                    isOn: $darkMode
                )

                SettingsDivider()

                SettingsToggleRow(
                    icon: "rectangle.3.group.fill",
                    color: .teal,
                    title: "Compact Cards",
                    subtitle: "Fit more announcements on screen",
                    isOn: $compactCards
                )

                SettingsDivider()

                SettingsRow(
                    icon: "textformat.size",
                    color: .green,
                    title: "Text Size",
                    value: "Default"
                )
            }
            .padding(.vertical, 4)
            .padding(.horizontal, 14)
            .background(Color.white)
            .cornerRadius(16)
            .shadow(color: .black.opacity(0.05), radius: 6, y: 2)
        }
    }

    // MARK: - General Section

    private var generalSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            sectionHeader("General")

            VStack(spacing: 0) {
                SettingsRow(
                    icon: "questionmark.circle.fill",
                    color: .blue,
                    title: "Help & Support"
                )

                SettingsDivider()

                SettingsRow(
                    icon: "lock.shield.fill",
                    color: .gray,
                    title: "Privacy Policy"
                )

                SettingsDivider()

                SettingsRow(
                    icon: "info.circle.fill",
                    color: .pink,
                    title: "About ChristConnect",
                    value: "v1.0.0"
                )
            }
            .padding(.vertical, 4)
            .padding(.horizontal, 14)
            .background(Color.white)
            .cornerRadius(16)
            .shadow(color: .black.opacity(0.05), radius: 6, y: 2)
        }
    }

    // MARK: - Sign Out Section

    private var signOutSection: some View {
        Button(action: {}) {
            HStack(spacing: 8) {
                Image(systemName: "rectangle.portrait.and.arrow.right")
                Text("Sign Out")
                    .bold()
            }
            .font(.subheadline)
            .foregroundColor(.red)
            .frame(maxWidth: .infinity)
            .padding(.vertical, 14)
            .background(Color.white)
            .cornerRadius(16)
            .shadow(color: .black.opacity(0.05), radius: 6, y: 2)
        }
    }

    // MARK: - Footer Section

    private var footerSection: some View {
        VStack(spacing: 4) {
            Text("ChristConnect")
                .font(.caption)
                .bold()
                .foregroundColor(.secondary)
            Text("Announcer v1.0.0")
                .font(.caption2)
                .foregroundColor(.secondary.opacity(0.7))
        }
        .frame(maxWidth: .infinity)
    }

    // MARK: - Helpers

    private func sectionHeader(_ title: String) -> some View {
        Text(title)
            .font(.title3)
            .bold()
    }
}

// MARK: - Settings Row (Navigation Style)

struct SettingsRow: View {
    let icon: String
    let color: Color
    let title: String
    var subtitle: String? = nil
    var value: String? = nil

    var body: some View {
        HStack(spacing: 12) {
            ZStack {
                RoundedRectangle(cornerRadius: 8)
                    .fill(color.opacity(0.15))
                    .frame(width: 32, height: 32)
                Image(systemName: icon)
                    .font(.system(size: 13))
                    .foregroundColor(color)
            }

            VStack(alignment: .leading, spacing: 2) {
                Text(title)
                    .font(.subheadline)
                if let subtitle {
                    Text(subtitle)
                        .font(.caption2)
                        .foregroundColor(.secondary)
                }
            }

            Spacer()

            if let value {
                Text(value)
                    .font(.caption)
                    .foregroundColor(.secondary)
            }

            Image(systemName: "chevron.right")
                .font(.caption2)
                .foregroundColor(.secondary.opacity(0.6))
        }
        .padding(.vertical, 8)
        .contentShape(Rectangle())
    }
}

// MARK: - Settings Toggle Row

struct SettingsToggleRow: View {
    let icon: String
    let color: Color
    let title: String
    var subtitle: String? = nil
    
    @Binding var isOn: Bool

    var body: some View {
        HStack(spacing: 12) {
            ZStack {
                RoundedRectangle(cornerRadius: 8)
                    .fill(color.opacity(0.15))
                    .frame(width: 32, height: 32)
                Image(systemName: icon)
                    .font(.system(size: 13))
                    .foregroundColor(color)
            }

            VStack(alignment: .leading, spacing: 2) {
                Text(title)
                    .font(.subheadline)
                if let subtitle {
                    Text(subtitle)
                        .font(.caption2)
                        .foregroundColor(.secondary)
                }
            }

            Spacer()

            Toggle("", isOn: $isOn)
                .labelsHidden()
                .tint(.blue)
        }
        .padding(.vertical, 8)
    }
}

// MARK: - Settings Divider

struct SettingsDivider: View {
    var body: some View {
        Divider()
            .overlay(Color.black.opacity(0.04))
            .padding(.leading, 44)
    }
}

// MARK: - Preview

#Preview {
    Settings()
}
