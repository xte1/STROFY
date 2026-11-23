import SwiftUI

struct AboutSettingsView: View {
    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                // صورة التطبيق والاسم
                VStack(spacing: 12) {
                    Image("StrofyLogo")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 100, height: 100)
                        .clipShape(RoundedRectangle(cornerRadius: 24, style: .continuous))
                        .shadow(color: .black.opacity(0.25), radius: 10, y: 5)

                    Text("STROFY")
                        .font(.title.weight(.bold))
                }
                .padding(.top, 16)

                // لمحة التطبيق
                VStack(alignment: .leading, spacing: 10) {
                    Text("عن التطبيق")
                        .font(.headline)
                        .frame(maxWidth: .infinity, alignment: .leading)

                    Text("تطبيق STROFY هو رفيقك الموسيقي المتكامل للاستماع إلى ملايين المقاطع الصوتية والأغاني بجودة عالية فائقة النقاء، مع إمكانية التحميل للاستماع بدون إنترنت، وعرض كلمات الأغاني المتزامنة، وتخصيص الصوت عبر معادل احترافي يمنحك تجربة استماع استثنائية صُممت بعناية لعشاق الموسيقى.")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                        .lineSpacing(5)
                        .multilineTextAlignment(.leading)
                }
                .padding(16)
                .background(
                    RoundedRectangle(cornerRadius: 16, style: .continuous)
                        .fill(Color(.secondarySystemGroupedBackground))
                )

                // معلومات المطور في المنتصف
                VStack(spacing: 14) {
                    Text("معلومات المطور")
                        .font(.headline)

                    VStack(spacing: 10) {
                        Link(destination: URL(string: "https://instagram.com/eng_azawy")!) {
                            HStack(spacing: 8) {
                                Image(systemName: "camera.fill")
                                Text("انستجرام: eng_azawy")
                                    .fontWeight(.medium)
                            }
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 10)
                            .background(Color(.tertiarySystemGroupedBackground))
                            .clipShape(RoundedRectangle(cornerRadius: 12))
                        }

                        Link(destination: URL(string: "https://t.me/bavarite")!) {
                            HStack(spacing: 8) {
                                Image(systemName: "paperplane.fill")
                                Text("تليجرام: bavarite")
                                    .fontWeight(.medium)
                            }
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 10)
                            .background(Color(.tertiarySystemGroupedBackground))
                            .clipShape(RoundedRectangle(cornerRadius: 12))
                        }

                        Link(destination: URL(string: "https://tiktok.com/@eyesiq")!) {
                            HStack(spacing: 8) {
                                Image(systemName: "music.note")
                                Text("تيك توك: eyesiq")
                                    .fontWeight(.medium)
                            }
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 10)
                            .background(Color(.tertiarySystemGroupedBackground))
                            .clipShape(RoundedRectangle(cornerRadius: 12))
                        }
                    }
                }
                .multilineTextAlignment(.center)
                .padding(16)
                .background(
                    RoundedRectangle(cornerRadius: 16, style: .continuous)
                        .fill(Color(.secondarySystemGroupedBackground))
                )

                Spacer(minLength: 20)

                // التوقيع في النهاية
                Text("صنع في العراق 🇮🇶")
                    .font(.footnote.weight(.bold))
                    .foregroundStyle(.secondary)
                    .padding(.bottom, 24)
            }
            .padding(.horizontal, 16)
        }
        .background(Color(.systemGroupedBackground))
        .navigationTitle("حول التطبيق")
        .navigationBarTitleDisplayMode(.inline)
        .miniPlayerTracksScroll()
    }
}
