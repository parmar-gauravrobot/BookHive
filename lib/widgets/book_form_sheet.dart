import 'package:flutter/material.dart';

import '../models/book.dart';

class BookFormSheet extends StatefulWidget {
  final Book? initial;
  final void Function(Book) onSubmit;

  const BookFormSheet({super.key, this.initial, required this.onSubmit});

  @override
  State<BookFormSheet> createState() => _BookFormSheetState();
}

class _BookFormSheetState extends State<BookFormSheet> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _title;
  late TextEditingController _author;
  String _status = 'to_read';
  int _progress = 0;

  @override
  void initState() {
    super.initState();
    _title = TextEditingController(text: widget.initial?.title ?? '');
    _author = TextEditingController(text: widget.initial?.author ?? '');
    _status = widget.initial?.status ?? 'to_read';
    _progress = widget.initial?.progressPercent ?? 0;
  }

  @override
  void dispose() {
    _title.dispose();
    _author.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom + 16,
        left: 16,
        right: 16,
        top: 16,
      ),
      child: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(widget.initial == null ? 'Add Book' : 'Edit Book', style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 12),
              TextFormField(
                controller: _title,
                decoration: const InputDecoration(labelText: 'Title'),
                validator: (v) => (v == null || v.trim().isEmpty) ? 'Title required' : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _author,
                decoration: const InputDecoration(labelText: 'Author'),
                validator: (v) => (v == null || v.trim().isEmpty) ? 'Author required' : null,
              ),
              const SizedBox(height: 12),
              DropdownButtonFormField<String>(
                value: _status,
                decoration: const InputDecoration(labelText: 'Status'),
                items: const [
                  DropdownMenuItem(value: 'to_read', child: Text('To Read')),
                  DropdownMenuItem(value: 'reading', child: Text('Reading')),
                  DropdownMenuItem(value: 'read', child: Text('Read')),
                ],
                onChanged: (v) => setState(() => _status = v ?? 'to_read'),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  const Text('Progress'),
                  Expanded(
                    child: Slider(
                      value: _progress.toDouble(),
                      min: 0,
                      max: 100,
                      divisions: 20,
                      label: '$_progress%',
                      onChanged: (v) => setState(() => _progress = v.round()),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              ElevatedButton(
                onPressed: () {
                  if (!_formKey.currentState!.validate()) return;
                  final book = Book(
                    id: widget.initial?.id,
                    title: _title.text.trim(),
                    author: _author.text.trim(),
                    status: _status,
                    progressPercent: _progress,
                    isFavorite: widget.initial?.isFavorite ?? false,
                  );
                  widget.onSubmit(book);
                  Navigator.of(context).pop();
                },
                child: Text(widget.initial == null ? 'Add' : 'Save'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


