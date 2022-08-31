import 'package:flutter/material.dart';
import 'package:network_2/customUi/decoration.dart';

class addMultipleStrings extends StatefulWidget {
  List<String> links;
  final String label;
  addMultipleStrings({this.links, this.label});
  @override
  _addMultipleStringsState createState() => _addMultipleStringsState();
}

class _addMultipleStringsState extends State<addMultipleStrings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: true,
      appBar: AppBar(
        backgroundColor: Colors.teal,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        title: Text("Add ${widget.label} \n (Max 10 items)"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 10,),
            widget.links.isNotEmpty ? Column(
              children: widget.links.map((link) => showCard(link: link, links: widget.links,)).toList(),
            ) : Container(),
            addCard(links: widget.links)
          ],
        ),
      ),
    );
  }
}

class showCard extends StatefulWidget {
  String link;
  List<String> links;
  showCard({this.link, this.links});
  @override
  _showCardState createState() => _showCardState();
}

class _showCardState extends State<showCard> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
        child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            elevation: 15,
            color: Colors.green[100],
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                      child: Text(widget.link,)
                  ),
                  IconButton(
                    onPressed: (){
                      setState(() {
                        widget.links.remove(widget.link);
                      });
                    },
                    icon: Icon(Icons.delete,),
                  ),
                ],
              ),
            )
        ),
      ),
    );
  }
}

class addCard extends StatefulWidget {
  List<String> links;
  addCard({this.links});
  @override
  _addCardState createState() => _addCardState();
}

class _addCardState extends State<addCard> {

  TextEditingController _link = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
        child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            elevation: 15,
            color: Colors.green[100],
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      maxLengthEnforced: true,
                      maxLength: 50,
                      controller: _link,
                      decoration: textFormDecoration("Type here", "", Icons.link),
                    ),
                  ),
                  IconButton(
                    onPressed: (){
                      if(_link.text.isNotEmpty){
                        FocusScope.of(context).unfocus();
                        setState(() {
                        widget.links.add(_link.text);
                      });
                        _link.clear();
                      }
                    },
                    icon: Icon(Icons.add,),
                  ),
                ],
              ),
            )
        ),
      ),
    );
  }
}