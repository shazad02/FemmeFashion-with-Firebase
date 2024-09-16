// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:kelompok5_a2/provider/product_provider.dart';
import 'package:kelompok5_a2/helper/theme.dart';
import 'package:kelompok5_a2/view/chekoutscreen/akhir_cekout.dart';
import 'package:kelompok5_a2/widget/button_custom.dart';

class SelectAlamat extends StatefulWidget {
  const SelectAlamat({super.key});

  @override
  _SelectAlamatState createState() => _SelectAlamatState();
}

class _SelectAlamatState extends State<SelectAlamat> {
  late ProductProvider productProvider;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? _user;
  String? _selectedAddress;
  Map<String, dynamic>? _selectedAddressData;

  @override
  void initState() {
    super.initState();
    _user = _auth.currentUser;
  }

  void _showAddressForm(
      {Map<String, dynamic>? existingAddress,
      DocumentReference? docRef}) async {
    final result = await showDialog<Map<String, dynamic>>(
      context: context,
      builder: (BuildContext context) {
        return AddressFormDialog(existingAddress: existingAddress);
      },
    );

    if (result != null) {
      if (docRef != null) {
        // Update the existing address in Firebase
        await docRef.update(result);
      } else {
        // Save the new address to Firebase with a timestamp
        await _firestore.collection('addresses').add({
          ...result,
          'timestamp': FieldValue.serverTimestamp(),
        });
      }
    }
  }

  void _navigateToNextScreen(BuildContext context) {
    if (_selectedAddressData != null) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => HasilCekout(addressData: _selectedAddressData!),
        ),
      );
    }
  }

  void _userAlamatScreen(BuildContext context) async {
    if (_user != null) {
      try {
        // Ambil data user dari koleksi 'users'
        DocumentSnapshot userSnapshot =
            await _firestore.collection('user').doc(_user!.uid).get();
        if (userSnapshot.exists) {
          Map<String, dynamic> userData =
              userSnapshot.data() as Map<String, dynamic>;
          Map<String, dynamic> addressData = {
            'ongkir': userData['ongkir'],
            'address': userData['address'],
            'phone': userData['phone'],
            'name': userData['name'],
            'userId': _user!.uid,
          };
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => HasilCekout(addressData: addressData),
            ),
          );
        } else {
          // Jika user tidak ditemukan
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('User data not found')),
          );
        }
      } catch (e) {
        // Tangani error
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error fetching user data: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Alamat",
          style: primaryTextStyle3.copyWith(color: Colors.white),
        ),
        backgroundColor: bg5color,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back)),
      ),
      body: _user == null
          ? const Center(child: Text('User not logged in'))
          : Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: () => _showAddressForm(),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.add_circle_outline,
                        color: bg6color,
                      ),
                      Text(
                        ' Tambah Alamat Baru',
                        style: primaryTextStyle2.copyWith(color: bg6color),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: AddressList(
                    selectedAddress: _selectedAddress,
                    onSelect: (address, addressData) {
                      setState(() {
                        _selectedAddress = address;
                        _selectedAddressData = addressData;
                      });
                    },
                    onEdit: (existingAddress, docRef) => _showAddressForm(
                        existingAddress: existingAddress, docRef: docRef),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(15),
                  child: ButtonCus(
                      textButton: "Alamat User",
                      onPressed: () => _userAlamatScreen(context),
                      buttomcolor: bg6color,
                      textcolor: Colors.white),
                ),
              ],
            ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(15),
        child: ButtonCus(
            textButton: "Pesan",
            onPressed: () => _navigateToNextScreen(context),
            buttomcolor: bg6color,
            textcolor: Colors.white),
      ),
    );
  }
}

class AddressFormDialog extends StatefulWidget {
  final Map<String, dynamic>? existingAddress;

  const AddressFormDialog({super.key, this.existingAddress});

  @override
  _AddressFormDialogState createState() => _AddressFormDialogState();
}

class _AddressFormDialogState extends State<AddressFormDialog> {
  final _formKey = GlobalKey<FormState>();
  final _addressController = TextEditingController();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  String? _selectedOngkir;
  List<String> _ongkirList = [];

  @override
  void initState() {
    super.initState();
    _loadOngkirData();

    if (widget.existingAddress != null) {
      _addressController.text = widget.existingAddress!['address'];
      _nameController.text = widget.existingAddress!['name'];
      _phoneController.text = widget.existingAddress!['phone'];
      _selectedOngkir = widget.existingAddress!['ongkir'];
    }
  }

  Future<void> _loadOngkirData() async {
    final snapshot =
        await FirebaseFirestore.instance.collection('ongkir').get();
    setState(() {
      _ongkirList = snapshot.docs.map((doc) => doc['name'] as String).toList();
    });
  }

  @override
  void dispose() {
    _addressController.dispose();
    _nameController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    return AlertDialog(
      title: const Text('Masukan Alamat Baru'),
      content: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Nama'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your name';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _phoneController,
                decoration: const InputDecoration(labelText: 'Nomer Hp'),
                keyboardType: TextInputType.phone,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your phone number';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _addressController,
                decoration: const InputDecoration(labelText: 'Alamat'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your address';
                  }
                  return null;
                },
              ),
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(labelText: 'Kabupaten'),
                value: _selectedOngkir,
                items: _ongkirList.map((ongkir) {
                  return DropdownMenuItem<String>(
                    value: ongkir,
                    child: Text(ongkir),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedOngkir = value;
                  });
                },
                validator: (value) {
                  if (value == null) {
                    return 'Please select an Kecamatan';
                  }
                  return null;
                },
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text(
            'Batal',
            style: primaryTextStyle2.copyWith(color: bg6color),
          ),
        ),
        ElevatedButton(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              Navigator.of(context).pop({
                'address': _addressController.text,
                'name': _nameController.text,
                'phone': _phoneController.text,
                'ongkir': _selectedOngkir,
                'userId': user?.uid,
              });
            }
          },
          child: Text(
            'Simpan',
            style: primaryTextStyle3.copyWith(color: bg6color),
          ),
        ),
      ],
    );
  }
}

class AddressList extends StatelessWidget {
  final String? selectedAddress;
  final Function(String, Map<String, dynamic>) onSelect;
  final Function(Map<String, dynamic>, DocumentReference) onEdit;

  const AddressList({
    super.key,
    required this.selectedAddress,
    required this.onSelect,
    required this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      return const Center(child: Text('Please log in to view addresses.'));
    }

    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('addresses')
          .where('userId', isEqualTo: user.uid)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }

        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return const Center(child: Text('Tidak Ada Alamat.'));
        }

        final addresses = snapshot.data!.docs;

        return ListView.builder(
          itemCount: addresses.length,
          itemBuilder: (context, index) {
            final addressData = addresses[index];
            final data = addressData.data() as Map<String, dynamic>;
            final address = data['address'];
            final name = data['name'];
            final phone = data['phone'];
            final ongkir = data['ongkir'];
            final docRef = addressData.reference;

            return GestureDetector(
              onTap: () => onEdit(data, docRef),
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: bg2Color,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset:
                            const Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  child: ListTile(
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '$name',
                          style: primaryTextStyle3.copyWith(
                              fontSize: 18, color: bg6color),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          '$phone',
                          style: primaryTextStyle2.copyWith(
                              fontSize: 15, color: bg5color),
                        ),
                      ],
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Kabupaten: $ongkir',
                          style: primaryTextStyle2.copyWith(
                              fontSize: 15, color: bg5color),
                        ),
                        Text(
                          'Alamat: $address',
                          style: primaryTextStyle2.copyWith(
                              fontSize: 15, color: bg5color),
                        ),
                      ],
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(
                            Icons.delete,
                            color: bg6color,
                          ),
                          onPressed: () async {
                            await docRef.delete();
                          },
                        ),
                      ],
                    ),
                    leading: Radio<String>(
                      value: address,
                      groupValue: selectedAddress,
                      onChanged: (value) {
                        if (value != null) {
                          onSelect(value, data);
                        }
                      },
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
