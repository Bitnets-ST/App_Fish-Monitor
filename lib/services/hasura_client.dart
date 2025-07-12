import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:flutter/material.dart';

class HasuraClient {
  static final HttpLink _httpLink = HttpLink(
    'YOUR_HASURA_ENDPOINT', // Reemplaza con tu endpoint de Hasura
  );

  static final AuthLink _authLink = AuthLink(
    getToken: () async => 'YOUR_HASURA_ADMIN_SECRET', // Reemplaza con tu admin secret
  );

  static final Link _link = _authLink.concat(_httpLink);

  static final GraphQLClient _client = GraphQLClient(
    link: _link,
    cache: GraphQLCache(),
  );

  static GraphQLClient get client => _client;

  // Queries
  static const String getCentrales = '''
    query GetCentrales {
      centrales {
        id
        nombre
        color
        salas {
          id
          nombre
          estado
          estanques {
            id
            nombre
            temperatura
            oxigeno
            ph
            estado
          }
        }
      }
    }
  ''';

  static const String getEstanqueDetails = '''
    query GetEstanqueDetails(\$id: Int!) {
      estanques_by_pk(id: \$id) {
        id
        nombre
        temperatura
        oxigeno
        ph
        estado
        sala {
          nombre
          central {
            nombre
          }
        }
        registros_monitoreo(order_by: {timestamp: desc}, limit: 24) {
          temperatura
          oxigeno
          ph
          timestamp
        }
      }
    }
  ''';

  // Mutations
  static const String updateEstanque = '''
    mutation UpdateEstanque(
      \$id: Int!
      \$temperatura: numeric
      \$oxigeno: numeric
      \$ph: numeric
      \$estado: String
    ) {
      update_estanques_by_pk(
        pk_columns: {id: \$id}
        _set: {
          temperatura: \$temperatura
          oxigeno: \$oxigeno
          ph: \$ph
          estado: \$estado
        }
      ) {
        id
        nombre
        temperatura
        oxigeno
        ph
        estado
      }
    }
  ''';

  static const String createRegistroMonitoreo = '''
    mutation CreateRegistroMonitoreo(
      \$estanque_id: Int!
      \$temperatura: numeric!
      \$oxigeno: numeric!
      \$ph: numeric!
    ) {
      insert_registros_monitoreo_one(object: {
        estanque_id: \$estanque_id
        temperatura: \$temperatura
        oxigeno: \$oxigeno
        ph: \$ph
      }) {
        id
        timestamp
      }
    }
  ''';
}

// Provider para usar Hasura en toda la aplicación
class HasuraProvider extends InheritedWidget {
  final GraphQLClient client;

  const HasuraProvider({
    Key? key,
    required this.client,
    required Widget child,
  }) : super(key: key, child: child);

  static HasuraProvider of(BuildContext context) {
    final HasuraProvider? result =
        context.dependOnInheritedWidgetOfExactType<HasuraProvider>();
    assert(result != null, 'No HasuraProvider found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(HasuraProvider oldWidget) {
    return client != oldWidget.client;
  }
} 