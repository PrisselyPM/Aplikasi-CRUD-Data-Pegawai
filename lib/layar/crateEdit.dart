import 'package:crud_karyawa/pegawai/karyawan.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

enum FormMode { create, edit }

class CreateEditScreen extends StatefulWidget {
  const CreateEditScreen({super.key, required this.mode, this.karyawan});

  final FormMode mode;
  final Karyawan? karyawan;

  @override
  State<CreateEditScreen> createState() => _CreateEditScreenState();
}

class _CreateEditScreenState extends State<CreateEditScreen> {
  final TextEditingController _namaController = TextEditingController();
  final TextEditingController _profController = TextEditingController();
  final TextEditingController _jkController = TextEditingController();
  final TextEditingController _alamatController = TextEditingController();
  final TextEditingController _teleponController = TextEditingController();
  final TextEditingController _gajiController = TextEditingController();

  @override
  initState() {
    super.initState();
    if (widget.mode == FormMode.edit) {
      _namaController.text = widget.karyawan!.nama;
      _profController.text = widget.karyawan!.prof;
      _jkController.text = widget.karyawan!.jk;
      _alamatController.text = widget.karyawan!.alamat;
      _teleponController.text = widget.karyawan!.telepon;
      _gajiController.text = widget.karyawan!.gaji;
    }
  }

  getKryn() {
    return Karyawan(
      nama: _namaController.text,
      prof: _profController.text,
      jk: _jkController.text,
      alamat: _alamatController.text,
      telepon: _teleponController.text,
      gaji: _gajiController.text,
    );
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: const Text('Data karyawan'),
        backgroundColor: Colors.blueGrey[100],
        trailing: GestureDetector(
          onTap: () {
            Navigator.pop(context, getKryn());
          },
          child: Text(widget.mode == FormMode.create ? 'Tambah' : 'Edit'),
        ),
      ),
      child: SafeArea(
        child: CupertinoFormSection(
          header: Text(widget.mode == FormMode.create
              ? 'Tambah Data karyawan'
              : 'Edit Data karyawan'),
          children: [
            CupertinoFormRow(
              prefix: Text('Nama  '),
              child: CupertinoTextFormFieldRow(
                controller: _namaController,
                placeholder: 'Masukkan nama',
              ),
            ),
            CupertinoFormRow(
              prefix: Text('Profesi   '),
              child: CupertinoTextFormFieldRow(
                controller: _profController,
                placeholder: 'Masukkan Profesi',
              ),
            ),
            CupertinoFormRow(
              prefix: Text('Jenis K '),
              child: CupertinoTextFormFieldRow(
                controller: _jkController,
                placeholder: 'Masukkan Jenis Kelamin',
              ),
            ),
            CupertinoFormRow(
              prefix: Text('Alamat  '),
              child: CupertinoTextFormFieldRow(
                controller: _alamatController,
                placeholder: 'Masukkan alamat',
              ),
            ),
            CupertinoFormRow(
              prefix: Text('No.Tlpn'),
              child: CupertinoTextFormFieldRow(
                controller: _teleponController,
                placeholder: 'Masukkan telepon',
              ),
            ),
            CupertinoFormRow(
              prefix: Text('Gaji'),
              child: CupertinoTextFormFieldRow(
                controller: _gajiController,
                placeholder: 'Masukkan Gaji',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
