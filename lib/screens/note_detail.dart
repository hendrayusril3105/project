import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_app/models/note.dart';
import 'package:flutter_app/utils/database_helper.dart';
import 'package:intl/intl.dart';

class NoteDetail extends StatefulWidget {

	final String appBarTitle;
	final Note note;

	NoteDetail(this. note, this.appBarTitle);

	@override
  State<StatefulWidget> createState() {

    return NoteDetailState(this.note, this.appBarTitle);
  }
}

class NoteDetailState extends State<NoteDetail> {

	static var _priorities = ['Kelas 5M', 'Others'];

	DatabaseHelper helper = DatabaseHelper();

	String appBarTitle;
	Note note;

	TextEditingController titleController = TextEditingController();
	TextEditingController descriptionController = TextEditingController();
  TextEditingController teleponController = TextEditingController();
  TextEditingController tanggalController = TextEditingController();
  TextEditingController alamatController = TextEditingController();
  TextEditingController emailController = TextEditingController();



	NoteDetailState(this.note, this.appBarTitle);

	@override
  Widget build(BuildContext context) {

		TextStyle textStyle = Theme.of(context).textTheme.title;

		titleController.text = note.title;
		descriptionController.text = note.description;
    teleponController.text = note.telepon;
    tanggalController.text = note.tanggal;
    alamatController.text = note.alamat;
    emailController.text = note.email;


    return WillPopScope(

	    onWillPop: () {
	    	// Write some code to control things, when user press Back navigation button in device navigationBar
		    moveToLastScreen();
	    },

	    child: Scaffold(
	    appBar: AppBar(
		    title: Text(appBarTitle),
		    leading: IconButton(icon: Icon(
				    Icons.arrow_back),
				    onPressed: () {
		    	    // Write some code to control things, when user press back button in AppBar
		    	    moveToLastScreen();
				    }
		    ),
	    ),

	    body: Padding(
		    padding: EdgeInsets.only(top: 15.0, left: 10.0, right: 10.0),
		    child: ListView(
			    children: <Widget>[

			    	// First element
				    ListTile(
					    title: DropdownButton(
							    items: _priorities.map((String dropDownStringItem) {
							    	return DropdownMenuItem<String> (
									    value: dropDownStringItem,
									    child: Text(dropDownStringItem),
								    );
							    }).toList(),

							    style: textStyle,

							    value: getPriorityAsString(note.priority),

							    onChanged: (valueSelectedByUser) {
							    	setState(() {
							    	  debugPrint('User selected $valueSelectedByUser');
							    	  updatePriorityAsInt(valueSelectedByUser);
							    	});
							    }
					    ),
				    ),

				    // Second Element
				    Padding(
					    padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
					    child: TextField(
						    controller: titleController,
						    style: textStyle,
						    onChanged: (value) {
						    	debugPrint('Something changed in Title Text Field');
						    	updateTitle();
						    },
						    decoration: InputDecoration(
							    labelText: 'NAMA',
							    labelStyle: textStyle,
							    border: OutlineInputBorder(
								    borderRadius: BorderRadius.circular(5.0)
							    )
						    ),
					    ),
				    ),

				    // Third Element
				    Padding(
					    padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
					    child: TextField(
						    controller: descriptionController,
						    style: textStyle,
						    onChanged: (value) {
							    debugPrint('Something changed in Title Text Field');
							    updateDescription();
						    },
						    decoration: InputDecoration(
								    labelText: 'NPM',
								    labelStyle: textStyle,
								    border: OutlineInputBorder(
										    borderRadius: BorderRadius.circular(5.0)
								    )
						    ),
					    ),
				    ),

            // Fourth Element
				    Padding(
					    padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
					    child: TextField(
						    controller: teleponController,
						    style: textStyle,
						    onChanged: (value) {
							    debugPrint('Something changed in Title Text Field');
							    updateTelepon();
						    },
						    decoration: InputDecoration(
								    labelText: 'TELEPON',
								    labelStyle: textStyle,
								    border: OutlineInputBorder(
										    borderRadius: BorderRadius.circular(5.0)
								    )
						    ),
					    ),
				    ),

				    // Fifth Element
				    Padding(
					    padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
					    child: TextField(
						    controller: tanggalController,
						    style: textStyle,
						    onChanged: (value) {
							    debugPrint('Something changed in Title Text Field');
							    updateTanggal();
						    },
						    decoration: InputDecoration(
								    labelText: 'TANGGAL LAHIR',
								    labelStyle: textStyle,
								    border: OutlineInputBorder(
										    borderRadius: BorderRadius.circular(5.0)
								    )
						    ),
					    ),
				    ),

				    // Sixth Element
				    Padding(
					    padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
					    child: TextField(
						    controller: alamatController,
						    style: textStyle,
						    onChanged: (value) {
							    debugPrint('Something changed in Title Text Field');
							    updateAlamat();

						    },
						    decoration: InputDecoration(
								    labelText: 'ALAMAT',
								    labelStyle: textStyle,
								    border: OutlineInputBorder(
										    borderRadius: BorderRadius.circular(5.0)
								    )
						    ),
					    ),
				    ),

				    // Seventh Element
				    Padding(
					    padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
					    child: TextField(
						    controller: emailController,
						    style: textStyle,
						    onChanged: (value) {
							    debugPrint('Something changed in Title Text Field');
							    updateEmail();
						    },
						    decoration: InputDecoration(
								    labelText: 'EMAIL',
								    labelStyle: textStyle,
								    border: OutlineInputBorder(
										    borderRadius: BorderRadius.circular(5.0)
								    )
						    ),
					    ),
				    ),

				    // Eighth Element
				    Padding(
					    padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
					    child: Row(
						    children: <Widget>[
						    	Expanded(
								    child: RaisedButton(
									    color: Theme.of(context).primaryColorDark,
									    textColor: Theme.of(context).primaryColorLight,
									    child: Text(
										    'SIMPAN',
										    textScaleFactor: 1.5,
									    ),
									    onPressed: () {
									    	setState(() {
									    	  debugPrint("Save button di klik");
									    	  _save();
									    	});
									    },
								    ),
							    ),

							    Container(width: 5.0,),

							    Expanded(
								    child: RaisedButton(
									    color: Theme.of(context).primaryColorDark,
									    textColor: Theme.of(context).primaryColorLight,
									    child: Text(
										    'HAPUS',
										    textScaleFactor: 1.5,
									    ),
									    onPressed: () {
										    setState(() {
											    debugPrint("Button Hapus Di Klik");
											    _delete();
										    });
									    },
								    ),
							    ),

						    ],
					    ),
				    ),

			    ],
		    ),
	    ),

    ));
  }

  void moveToLastScreen() {
		Navigator.pop(context, true);
  }

	// Convert the String priority in the form of integer before saving it to Database
	void updatePriorityAsInt(String value) {
		switch (value) {
			case 'Kelas 5M':
				note.priority = 1;
				break;
			case 'Others':
				note.priority = 2;
				break;
		}
	}

	// Convert int priority to String priority and display it to user in DropDown
	String getPriorityAsString(int value) {
		String priority;
		switch (value) {
			case 1:
				priority = _priorities[0];  // 'Kelas 5M'
				break;
			case 2:
				priority = _priorities[1];  // 'Others'
				break;
		}
		return priority;
	}

	// Update the title of Note object
  void updateTitle(){
    note.title = titleController.text;
  }

	// Update the description of Note object
	void updateDescription() {
		note.description = descriptionController.text;

	}

void updateTelepon() {
		note.telepon = teleponController.text;

	}

  void updateTanggal() {
		note.tanggal = tanggalController.text;

	}

  void updateAlamat() {
		note.alamat = alamatController.text;

	}

  void updateEmail() {
		note.email = emailController.text;

	}

// ini nah jua tambahi nggi
	// Save data to database
	void _save() async {

		moveToLastScreen();

		note.date = DateFormat.yMMMd().format(DateTime.now());
		int result;
		if (note.id != null) {  // Case 1: Update operation
			result = await helper.updateNote(note);
		} else { // Case 2: Insert Operation
			result = await helper.insertNote(note);
		}

		if (result != 0) {  // Success
			_showAlertDialog('Status', 'Catatan Berhasil Disimpan');
		} else {  // Failure
			_showAlertDialog('Status', 'Ada Masalah Saat Menyimpan');
		}

	}

	void _delete() async {

		moveToLastScreen();

		// Case 1: If user is trying to delete the NEW NOTE i.e. he has come to
		// the detail page by pressing the FAB of NoteList page.
		if (note.id == null) {
			_showAlertDialog('Status', 'Gagal Menghapus Catatan');
			return;
		}

		// Case 2: User is trying to delete the old note that already has a valid ID.
		int result = await helper.deleteNote(note.id);
		if (result != 0) {
			_showAlertDialog('Status', 'Berhasil Menghapus Catatan');
		} else {
			_showAlertDialog('Status', 'Error Saat Mengahapus');
		}
	}

	void _showAlertDialog(String title, String message) {

		AlertDialog alertDialog = AlertDialog(
			title: Text(title),
			content: Text(message),
		);
		showDialog(
				context: context,
				builder: (_) => alertDialog
		);
	}

}










