import SwiftUI

struct CameraPickerView: UIViewControllerRepresentable {
    @Environment(\.dismiss) private var dismiss

    let onImagePicked: (UIImage) -> Void

    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        return picker
    }

    func updateUIViewController(_: UIImagePickerController, context _: Context) {}

    func makeCoordinator() -> Coordinator {
        Coordinator(
            onDismiss: { dismiss() },
            onImagePicked: onImagePicked
        )
    }

    final class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        private let onDismiss: () -> Void
        private let onImagePicked: (UIImage) -> Void

        init(onDismiss: @escaping () -> Void, onImagePicked: @escaping (UIImage) -> Void) {
            self.onDismiss = onDismiss
            self.onImagePicked = onImagePicked
        }

        public func imagePickerController(_: UIImagePickerController,
                                          didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any])
        {
            if let image = info[.originalImage] as? UIImage {
                onImagePicked(image)
            }
            onDismiss()
        }

        public func imagePickerControllerDidCancel(_: UIImagePickerController) {
            onDismiss()
        }
    }
}
