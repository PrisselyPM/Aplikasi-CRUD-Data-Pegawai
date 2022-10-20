import 'package:crud_karyawa/pegawai/karyawan.dart';
import 'package:crud_karyawa/layar/crateEdit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Karyawan> _listKaryawan = [
    Karyawan(
        nama: 'Prissely Pravastifani Mediana',
        prof: 'Developer',
        jk: 'P',
        alamat: 'Randu Barat 3 no. 6',
        telepon: '+628231123',
        gaji: '7.000.000,00')
  ];

  // Popup untuk menampilkan pilhan edit dan hapus
  _showPopupMenuItem(BuildContext context, int index) {
    final karyawanClicked = _listKaryawan[index];
    print(karyawanClicked.nama);
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => CupertinoActionSheet(
        title: Text('Karyawan ${karyawanClicked.nama}'),
        actions: <CupertinoActionSheetAction>[
          CupertinoActionSheetAction(
            onPressed: () async {
              Navigator.pop(context);
              final result = await Navigator.push(
                  context,
                  CupertinoPageRoute(
                      builder: (context) => CreateEditScreen(
                            mode: FormMode.edit,
                            karyawan: karyawanClicked,
                          )));
              if (result is Karyawan) {
                setState(() {
                  _listKaryawan[index] = result;
                });
              }
            },
            child: const Text('Edit'),
          ),
          CupertinoActionSheetAction(
            isDestructiveAction: true,
            onPressed: () {
              Navigator.pop(context);
              showCupertinoModalPopup<void>(
                context: context,
                builder: (BuildContext context) => CupertinoAlertDialog(
                  title: const Text('Apakah anda yakin?'),
                  content: Text(
                      'Data Karyawan ${karyawanClicked.nama} akan dihapus'),
                  actions: <CupertinoDialogAction>[
                    CupertinoDialogAction(
                      isDefaultAction: true,
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text('Tidak'),
                    ),
                    CupertinoDialogAction(
                      isDestructiveAction: true,
                      onPressed: () {
                        Navigator.pop(context);
                        setState(() {
                          _listKaryawan.removeAt(index);
                        });
                      },
                      child: const Text('Iya'),
                    ),
                  ],
                ),
              );
            },
            child: const Text('Hapus'),
          ),
        ],
      ),
    );
  }

  // tampillan
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          actions: <Widget>[
            // icon untuk mengarah ke form penambahan data karyawan
            IconButton(
                onPressed: () async {
                  final result = await Navigator.push(
                      context,
                      CupertinoPageRoute(
                          builder: (context) =>
                              const CreateEditScreen(mode: FormMode.create)));
                  if (result is Karyawan) {
                    setState(() {
                      _listKaryawan.add(result);
                    });
                  }
                },
                icon: new Icon(Icons.add))
          ],
          title: Text("Data Karyawan"),
          flexibleSpace: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: <Color>[Colors.green, Colors.blue])),
          ),
          centerTitle: true,
        ),
        body: new SafeArea(
            child: ListView.separated(
                itemCount: _listKaryawan.length,
                itemBuilder: ((context, index) {
                  final ky = _listKaryawan[index];
                  return Container(
                    margin: EdgeInsets.only(top: 20),
                    child: GestureDetector(
                      onTap: (() => _showPopupMenuItem(context, index)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            '${ky.nama}',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            '${ky.prof}',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          Text('${ky.jk} / JL ${ky.alamat} / ${ky.telepon}',
                              style: TextStyle(fontSize: 14)),
                          Text('Rp. ${ky.gaji}',
                              style: TextStyle(fontSize: 14)),
                        ],
                      ),
                    ),
                  );
                }),
                separatorBuilder: (context, index) {
                  return const Divider();
                })),
      ),
    );
  }
}
