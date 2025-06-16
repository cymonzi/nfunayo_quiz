// floatingActionButton: SpeedDial(
//   animatedIcon: AnimatedIcons.menu_close,
//   backgroundColor: Colors.blue,
//   overlayColor: Colors.black,
//   overlayOpacity: 0.4,
//   spacing: 12,
//   children: [
//     SpeedDialChild(
//       child: const Icon(Icons.info),
//       label: 'About',
//       onTap: () => showDialog(
//         context: context,
//         builder: (context) => AlertDialog(
//           title: const Text('About Nfunayo'),
//           content: const Text(
//             'Nfunayo is a next-level expense tracker under the SMK MoneyKind company.',
//           ),
//           actions: [
//             TextButton(
//               onPressed: () => Navigator.of(context).pop(),
//               child: const Text('Close'),
//             ),
//           ],
//         ),
//       ),
//     ),
//     SpeedDialChild(
//       child: const Icon(Icons.help_outline),
//       label: 'Help & Support',
//       onTap: () => showDialog(
//         context: context,
//         builder: (context) => AlertDialog(
//           title: const Text('Help & Support'),
//           content: const Text('For assistance, contact us at 0759081487'),
//           actions: [
//             TextButton(
//               onPressed: () => Navigator.of(context).pop(),
//               child: const Text('Close'),
//             ),
//           ],
//         ),
//       ),
//     ),
//     SpeedDialChild(
//       child: const Icon(Icons.feedback),
//       label: 'Feedback',
//       onTap: () => showDialog(
//         context: context,
//         builder: (context) => AlertDialog(
//           title: const Text('Feedback'),
//           content: TextField(
//             maxLines: 4,
//             decoration: const InputDecoration(
//               labelText: 'Your Feedback',
//               border: OutlineInputBorder(),
//             ),
//           ),
//           actions: [
//             TextButton(
//               onPressed: () => Navigator.of(context).pop(),
//               child: const Text('Cancel'),
//             ),
//             TextButton(
//               onPressed: () {
//                 // Handle feedback submission
//                 Navigator.of(context).pop();
//               },
//               child: const Text('Submit'),
//             ),
//           ],
//         ),
//       ),
//     ),
//     SpeedDialChild(
//       child: const Icon(Icons.logout),
//       label: 'Logout',
//       onTap: () => showDialog(
//         context: context,
//         builder: (context) => AlertDialog(
//           title: const Text('Confirm'),
//           content: const Text('Are you sure you want to logout?'),
//           actions: [
//             TextButton(
//               onPressed: () => Navigator.of(context).pop(),
//               child: const Text('Cancel'),
//             ),
//             TextButton(
//               onPressed: () {
//                 Navigator.of(context).pop();
//                 _logout();
//               },
//               child: const Text('Logout'),
//             ),
//           ],
//         ),
//       ),
//     ),
//   ],
// ),
