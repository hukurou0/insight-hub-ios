import PhotosUI
import SwiftUI

struct BookCreationView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var viewModel: BookCreationViewModel

    init(lastCreatedBook: Binding<BookModel?>) {
        viewModel = .init(lastCreatedBook: lastCreatedBook)
    }

    public var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 20) {
                    Group {
                        if let imageData = viewModel.imageData, let image = UIImage(data: imageData) {
                            Image(uiImage: image)
                                .resizable()
                                .scaledToFit()
                                .cornerRadius(radius: 30)
                                .overlay(alignment: .bottomTrailing) {
                                    if viewModel.bookAnalysisResult != nil {
                                        Button {
                                            viewModel.clearAnalyzedData()
                                        } label: {
                                            Image(systemName: "arrow.clockwise")
                                                .foregroundStyle(Color(.label))
                                                .bold()
                                                .padding(12)
                                                .background(.regularMaterial)
                                                .clipShape(Circle())
                                        }
                                        .offset(x: 20, y: 20)
                                        .shadow(color: .black.opacity(0.2), radius: 10)
                                        .disabled(viewModel.isImageBeingAnalyzed || viewModel.isSaving)
                                    }
                                }
                                .frame(minWidth: 0, maxHeight: 300)
                        } else {
                            Rectangle()
                                .fill(.regularMaterial)
                                .frame(minWidth: 0, maxWidth: .infinity)
                                .frame(height: 300)
                                .cornerRadius(radius: 30)
                        }
                    }
                    .shadow(color: .black.opacity(0.2), radius: 20, y: 5)
                    .padding(.horizontal)

                    if viewModel.bookAnalysisResult == nil {
                        VStack(spacing: 20) {
                            HStack(spacing: 10) {
                                PhotosPicker(selection: $viewModel.imageItem, matching: .images) {
                                    Text("ライブラリから選択")
                                        .lineLimit(1)
                                        .minimumScaleFactor(0.01)
                                }
                                .buttonStyle(IHButtonStyle())
                                .disabled(viewModel.isImageBeingAnalyzed)
                                .onChange(of: viewModel.imageItem, viewModel.processImagePickedByLibrary)

                                Button {
                                    viewModel.analyzeImage()
                                } label: {
                                    Text("カメラで撮影")
                                        .lineLimit(1)
                                        .minimumScaleFactor(0.01)
                                }
                                .buttonStyle(IHButtonStyle())
                                .disabled(viewModel.isImageBeingAnalyzed)
                            }
                            .shadow(color: .black.opacity(0.2), radius: 20, y: 5)

                            Button {
                                viewModel.analyzeImage()
                            } label: {
                                Text("解析")
                            }
                            .buttonStyle(IHButtonStyle(isLoading: viewModel.isImageBeingAnalyzed))
                            .disabled(viewModel.imageData == nil || viewModel.isImageBeingAnalyzed)
                        }
                    }

                    if viewModel.bookAnalysisResult != nil {
                        VStack(spacing: 20) {
                            IHTextField(title: "タイトル", required: true, text: $viewModel.title)

                            IHTextField(title: "著者", required: true, text: $viewModel.author)

                            HStack {
                                Text("カテゴリ")
                                Spacer()
                                Picker("", selection: $viewModel.category) {
                                    Text("選択してください")
                                        .tag(nil as BookCategory?)
                                    ForEach(BookCategory.allCases, id: \.self) { category in
                                        Text(category.rawValue)
                                            .tag(category)
                                    }
                                }
                                .labelsHidden()
                            }
                            .padding(10)
                            .background(.clear)
                            .cornerRadius()
                            .stroke(color: Color(.systemGray5), lineWidth: 2)
                        }
                    }
                }
                .padding()
            }
            .navigationTitle("本の登録")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        dismiss()
                    } label: {
                        Text("キャンセル")
                    }
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        viewModel.save()
                    } label: {
                        HStack {
                            if viewModel.isSaving {
                                ProgressView()
                            }
                            Text("登録")
                                .bold()
                        }
                    }
                    .disabled(viewModel.bookAnalysisResult == nil || viewModel.isSaving)
                }
            }
            .onChange(of: viewModel.isSaving) { oldValue, newValue in
                if oldValue == true, newValue == false {
                    dismiss()
                }
            }
            .sheet(isPresented: $viewModel.isCameraPickerShown) {
                CameraPickerView(onImagePicked: viewModel.processImagePickedByCamera(_:))
            }
        }
        .alert(using: $viewModel.alertController)
    }
}
