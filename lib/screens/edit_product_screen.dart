import 'package:flutter/material.dart';
import 'package:my_shop2/providers/product.dart';

class EditProductScreen extends StatefulWidget {
  static const routeName = '/edit-product';

  const EditProductScreen({super.key});

  @override
  State<EditProductScreen> createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  final _priceFocusNode = FocusNode();
  final _descFocusNode = FocusNode();
  final _imageUrlController = TextEditingController();
  final _imageUrlFocusNode = FocusNode();
  final _form = GlobalKey<FormState>();
  var _editedProduct = Product(
    id: '',
    title: '',
    description: '',
    price: 0,
    imageUrl: '',
  );

  @override
  void initState() {
    _imageUrlFocusNode.addListener(_updateImageUrl);
    super.initState();
  }

  @override
  void dispose() {
    // !! prevent memory leak
    _imageUrlFocusNode.removeListener(_updateImageUrl);
    _priceFocusNode.dispose();
    _descFocusNode.dispose();
    _imageUrlController.dispose();
    _imageUrlFocusNode.dispose();

    super.dispose();
  }

  void _updateImageUrl() {
    if (!_imageUrlFocusNode.hasFocus) {
      if (_imageUrlController.text.isEmpty ||
          (!_imageUrlController.text.startsWith('http') &&
              !_imageUrlController.text.startsWith('https')) ||
          (!_imageUrlController.text.endsWith('.png') &&
              !_imageUrlController.text.endsWith('.jpg') &&
              !_imageUrlController.text.endsWith('.jpeg'))) {
        return;
      }
      setState(() {});
    }
  }

  void _saveForm() {
    final isValid = _form.currentState?.validate();
    _form.currentState?.save();

    if (isValid == null || !isValid) {
      return;
    }
    print(_editedProduct.title);
    print(_editedProduct.price);
    print(_editedProduct.description);
    print(_editedProduct.imageUrl);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Product'),
        actions: [
          IconButton(
            onPressed: _saveForm,
            icon: Icon(
              Icons.save,
            ),
          )
        ],
      ),
      body: Form(
        key: _form,
        child: ListView(children: [
          TextFormField(
            decoration: InputDecoration(labelText: 'Title'),
            textInputAction: TextInputAction.next,
            onFieldSubmitted: (_) {
              FocusScope.of(context).requestFocus(_priceFocusNode);
            },
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please provide a value';
              }
              return null;
            },
            onSaved: (newValue) {
              _editedProduct = Product(
                id: '',
                title: newValue!,
                description: _editedProduct.description,
                price: _editedProduct.price,
                imageUrl: _editedProduct.imageUrl,
              );
            },
          ),
          TextFormField(
            decoration: InputDecoration(labelText: 'Price'),
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.number,
            focusNode: _priceFocusNode,
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please enter a price.';
              }
              if (double.tryParse(value) == null) {
                return 'Please enter a valid number.';
              }
              if (double.parse(value) <= 0) {
                return 'Please enter a nuber greater than zero.';
              }
              return null;
            },
            onFieldSubmitted: (_) {
              FocusScope.of(context).requestFocus(_descFocusNode);
            },
            onSaved: (newValue) {
              _editedProduct = Product(
                id: '',
                title: _editedProduct.title,
                description: _editedProduct.description,
                price: double.parse(newValue!),
                imageUrl: _editedProduct.imageUrl,
              );
            },
          ),
          TextFormField(
              decoration: InputDecoration(labelText: 'Description'),
              maxLines: 3,
              keyboardType: TextInputType.multiline,
              focusNode: _descFocusNode,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter a descroption';
                }
                return null;
              },
              onSaved: (newValue) {
                _editedProduct = Product(
                  id: '',
                  title: _editedProduct.title,
                  description: newValue!,
                  price: _editedProduct.price,
                  imageUrl: _editedProduct.imageUrl,
                );
              }),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                width: 100,
                height: 100,
                margin: EdgeInsets.only(
                  top: 8,
                  right: 10,
                ),
                decoration: BoxDecoration(
                  border: Border.all(
                    width: 1,
                    color: Colors.grey,
                  ),
                ),
                child: _imageUrlController.text.isEmpty
                    ? Text('Enter a URL')
                    : FittedBox(
                        child: Image.network(
                          _imageUrlController.text,
                        ),
                        fit: BoxFit.cover,
                      ),
              ),
              Expanded(
                child: TextFormField(
                    decoration: InputDecoration(labelText: 'Image Url'),
                    keyboardType: TextInputType.url,
                    textInputAction: TextInputAction.done,
                    controller: _imageUrlController,
                    focusNode: _imageUrlFocusNode,
                    onFieldSubmitted: (_) {
                      _saveForm();
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter an image URL';
                      }
                      if (!value!.startsWith('http') &&
                          !value!.startsWith('https')) {
                        return 'Enter a valid URL';
                      }
                      if (!value!.endsWith('.png') &&
                          !value!.endsWith('.jpg') &&
                          !value!.endsWith('.jpeg')) {
                        return 'Please enter a valid image URL.';
                      }
                      return null;
                    },
                    onSaved: (newValue) {
                      _editedProduct = Product(
                        id: '',
                        title: _editedProduct.title,
                        description: _editedProduct.description,
                        price: _editedProduct.price,
                        imageUrl: newValue!,
                      );
                    }),
              ),
            ],
          )
        ]),
      ),
    );
  }
}
