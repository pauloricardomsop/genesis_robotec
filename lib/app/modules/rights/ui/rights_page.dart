import 'package:flutter/material.dart';
import 'package:genesis_robotec/app/core/components/h.dart';

class RightsPage extends StatefulWidget {
  const RightsPage({super.key});

  @override
  State<RightsPage> createState() => _RightsPageState();
}

class _RightsPageState extends State<RightsPage> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: const [
        Text('Declaração de direitos autorais',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Color(0xFF3B3B3B),
                fontFamily: 'SpaceGrotesk',
                fontSize: 18)),
        H(16),
        Text(
            'Todas as informações incluídas neste site, como texto, gráficos, fotos, o logotipo e as imagens da Genesis Robotec bem como os produtos na configuração de kits de construção, são de propriedade exclusiva da Gênesis Robótica e Tecnologia ME e protegidas pelas leis de direitos autorais.\n\nA permissão para visualizar e fotocopiar (ou imprimir) materiais deste site é concedida apenas para uso pessoal e não comercial. Qualquer outra cópia, distribuição, retransmissão ou modificação das informações contidas neste documento, na forma eletrônica ou impressa, sem permissão anterior expressa por escrito da Gênesis Robotica e Tecnologia ME , é estritamente proibida.\n\nNo caso de qualquer cópia, redistribuição ou publicação permitida de material com direitos autorais, nenhuma mudança ou exclusão de atribuição do autor, legenda de marca registrada ou de aviso de direitos autorais deverá ser feita.À Gênesis Robótica e Tecnologia ME se reserva o direito exclusivo de uso da marca comercial Gênesis Robotec.',
            style: TextStyle(
                color: Color(0xFF373F4A),
                fontSize: 14,
                fontFamily: 'SpaceGrotesk',
                fontWeight: FontWeight.normal))
      ],
    );
  }
}
