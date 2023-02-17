import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class MarkerUpdate {
  final String id;
  final String strID;
  final String username;
  final String usericon;
  final String image;
  final double lat;
  final double lng;
  final double zoom;
  final String loc;
  final String species;
  final List date;
  final String time;
  final String title;
  final String info;
  final String site;
  final String color;
  final bool hide;
  final double temp;
  final String updatesLis;
  final List dataEntries;
  final List logs;
  //small reminder you can have MarkerUpdate in a Marker Update object within a list

  const MarkerUpdate({
    required this.id,
    required this.strID,
    required this.username,
    required this.usericon,
    required this.image,
    required this.lat,
    required this.lng,
    required this.zoom,
    required this.loc,
    required this.species,
    required this.date,
    required this.time,
    required this.title,
    required this.info,
    required this.site,
    required this.color,
    required this.hide,
    required this.temp,
    required this.updatesLis,
    required this.dataEntries,
    required this.logs,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'strID': strID,
        'username': username,
        'usericon': usericon,
        'image': image,
        'lat': lat,
        'lng': lng,
        'zoom': zoom,
        'loc': loc,
        'species': species,
        'date': date,
        'time': time,
        'title': title,
        'info': info,
        'site': site,
        'color': color,
        'hide': hide,
        'temp': temp,
        'updates': updatesLis,
        'dataEntries': dataEntries,
        'logs': logs,
      };

  static MarkerUpdate fromJson(Map<String, dynamic> json) => MarkerUpdate(
      id: json['id'],
      strID: json['strID'],
      username: json['username'],
      usericon: json['usericon'],
      image: json['image'],
      lat: json['lat'],
      lng: json['lng'],
      zoom: json['zoom'],
      loc: json['loc'],
      species: json['species'],
      date: json['date'],
      time: json['time'],
      title: json['title'],
      info: json['info'],
      site: json['site'],
      color: json['color'],
      hide: json['hide'],
      temp: json['temp'],
      updatesLis: json['updates'],
      dataEntries: json['dataEntries'],
      logs: json['logs']);
}

class Update {
  final String topic;
  final int number;
  final String image;
  final String text;
  final String context;

  const Update({
    required this.topic,
    required this.number,
    required this.image,
    required this.text,
    required this.context,
  });
}

class Account {
  final String username;
  final String id;
  final String usericon;
  final String name;
  final String loc;
  final String gender;
  final String email;

  const Account({
    required this.username,
    required this.id,
    required this.usericon,
    required this.name,
    required this.loc,
    required this.gender,
    required this.email,
  });

  Map<String, dynamic> toJson() => {
        'username': username,
        'id': id,
        'usericon': usericon,
        'name': name,
        'loc': loc,
        'gender': gender,
        'email': email
      };

  static Account fromJson(Map<String, dynamic> json) => Account(
      username: json['username'],
      id: json['id'],
      usericon: json['usericon'],
      name: json['name'],
      loc: json['loc'],
      gender: json['gender'],
      email: json['email']);
}
