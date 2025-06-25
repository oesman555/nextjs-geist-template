class EthService {
  // Mock Ethereum testnet integration with in-memory storage for demo

  final List<String> _notes = [];

  Future<void> init() async {
    // Simulate initialization delay
    await Future.delayed(Duration(seconds: 1));
  }

  Future<void> storeNote(String note) async {
    // Simulate network delay
    await Future.delayed(Duration(milliseconds: 500));
    _notes.add(note);
  }

  Future<List<String>> getNotes() async {
    // Simulate network delay
    await Future.delayed(Duration(milliseconds: 500));
    return List<String>.from(_notes);
  }
}
