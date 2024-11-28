import 'package:flutter/material.dart';
import 'package:geolocalizacion/domain/providers/incident_provider.dart';
import 'package:geolocalizacion/presentation/widgets/shared/info_card.dart';
import 'package:provider/provider.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final incidentProvider =
          Provider.of<IncidentProvider>(context, listen: false);
      incidentProvider.getIncidents();
    });
  }

  @override
  Widget build(BuildContext context) {
    final incidentProvider = Provider.of<IncidentProvider>(context);
    if (incidentProvider.isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
    if (incidentProvider.incidents.isEmpty) {
      return const Center(
        child: Text("No hay incidentes disponibles"),
      );
    }
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              "Incident Map",
              style: TextStyle(fontSize: 32, fontWeight: FontWeight.w900),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InfoCard(
                    value: incidentProvider.incidents.length.toString(),
                    title: "Incidentes",
                    color: Colors.blueGrey),
                InfoCard(
                    value: incidentProvider.trafficCount.toString(),
                    title: "Trafico",
                    color: Colors.blueGrey),
                InfoCard(
                    value: incidentProvider.theftCount.toString(),
                    title: "Robos",
                    color: Colors.red),
              ],
            ),
            const SizedBox(
              height: 12,
            ),
            const Text(
              "Ultimos incidentes registrados",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w900,
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: incidentProvider.incidents.length,
                itemBuilder: (context, index) {
                  final incident = incidentProvider.incidents[index];
                  return Card(
                    color: Colors.white,
                    child: ListTile(
                      leading: const Icon(Icons.warning_amber_rounded,
                          color: Colors.orangeAccent),
                      title: Text(
                        incident.title,
                        style: const TextStyle(
                          fontWeight: FontWeight.w900,
                          color: Colors.black,
                        ),
                      ),
                      subtitle: Text(
                        incident.address ?? "",
                        style: TextStyle(color: Colors.grey[500]),
                      ),
                      trailing: Icon(
                        incident.isEmailSent ? Icons.check_circle : Icons.error,
                        color: incident.isEmailSent ? Colors.green : Colors.red,
                      ),
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
