import 'package:flutter/material.dart';
import 'package:genesis_robotec/app/core/components/h.dart';

class AboutPage extends StatefulWidget {
  const AboutPage({super.key});

  @override
  State<AboutPage> createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text('Sobre',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF34AC04),
                      fontFamily: 'SpaceGrotesk',
                      fontSize: 18)),
              H(8),
              Text(
                  'A Gênesis Robótica e Tecnologia é uma empresa que busca espercializar-se continuamento no desenvolvimento de materiais e métodos didáticos tecnológicos para atender a dinâmica do cenário educacional vigente\n\nNossos produtos são desenvolvidos tomando como referências estudos e pesquisar acadêmicas na área de educção e tecnologias educacionais\n\nNosso objetivo é estimular a criatividade e gosto pelas ciências aliando tecnologia e consciência ambiental',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF373F4A),
                      fontSize: 16,
                      fontFamily: 'SpaceGrotesk')),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.all(16),
          color: const Color(0xFFF2F2F2),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Nossos Produtos',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF34AC04),
                      fontSize: 16,
                      fontFamily: 'SpaceGrotesk')),
              const H(16),
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Container(
                  width: double.maxFinite,
                  color: const Color(0xFF34AC04),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(16), bottomRight: Radius.circular(16)),
                        child: SizedBox(
                          width: double.maxFinite,
                          height: 200,
                          child: Image.network(
                            'https://thumbs.dreamstime.com/b/dois-irm%C3%A3os-crian%C3%A7as-brincando-com-um-brinquedo-rob%C3%B4-na-aula-de-rob%C3%B3tica-em-ambientes-fechados-t%C3%A9cnicos-curiosos-v%C3%A1rias-192041430.jpg',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text('ROBÓTICA INTELIGENTE',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFFFFFFFF),
                                    fontSize: 18,
                                    fontFamily: 'SpaceGrotesk')),
                            H(8),
                            Text(
                                'Conheça nossa linha de produtos para atividades laboratoriais de robótica totalmente em MDF',
                                style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    color: Color(0xFFFFFFFF),
                                    fontSize: 18,
                                    fontFamily: 'SpaceGrotesk'))
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text('Benefícios',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF34AC04),
                      fontSize: 16,
                      fontFamily: 'SpaceGrotesk')),
              H(8),
              Text('Expresse seu espírito',
                  style: TextStyle(
                      fontWeight: FontWeight.w800,
                      color: Color(0xFF3B3B3B),
                      fontSize: 16,
                      fontFamily: 'SpaceGrotesk')),
              H(4),
              Text(
                  'Robótica, programaõa e atividades Maker se configuram não somente como necessidades formativas profissionais e sim como práticas do dia a dia que vão além do domínio científico e tecnológico estando estas entre as formar contemporâneas de expressão de arte, cultura e espírito humano.',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF373F4A),
                      fontSize: 16,
                      fontFamily: 'SpaceGrotesk')),
              H(16),
              Text('Pensando no meio ambiente',
                  style: TextStyle(
                      fontWeight: FontWeight.w800,
                      color: Color(0xFF3B3B3B),
                      fontSize: 16,
                      fontFamily: 'SpaceGrotesk')),
              H(4),
              Text(
                  'Nosso pricipais kits laboratoriais utilizam materiais recicláveis em sua composição, entre eles o MDF (medium density fiberboard) obtidas de madeira de reflorestamento e o papeção ondulado facilmente recicláveis em comparação a estruturas plásticas.\n\nNosso compromisso é utilizar fontes de menor impacto ambiental bem como facilitar os processos de reciclagem de nosso produto, aliando aprendizagem, arte e tecnologia à consciência ambiental.',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF373F4A),
                      fontSize: 16,
                      fontFamily: 'SpaceGrotesk')),
            ],
          ),
        ),
        Container(
          color: const Color(0xFF34AC04),
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const H(8),
              const Text('Contato',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFFFFFFF),
                      fontSize: 18,
                      fontFamily: 'SpaceGrotesk')),
              const H(8),
              itemContact('Email', 'genesisrobotec@gmail.com'),
              itemContact('Email de ajuda', 'suportetecnicogenesisrobotec@gmail.com'),
              itemContact('Instagram', 'genesis_robotec'),
              itemContact('YouTube:', 'Genesis Robotec'),
              itemContact('Endereço:', 'Av. engenheiro Luiz Montenegro, 732, Siqueira'),
              const H(8),
            ],
          ),
        ),
      ],
    );
  }

  Widget itemContact(String title, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const H(12),
        Text(title,
            style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Color(0xFFFFFFFF),
                fontSize: 16,
                fontFamily: 'SpaceGrotesk')),
        const H(4),
        Text(value,
            style: const TextStyle(
                color: Color(0xFFFFFFFF), fontSize: 16, fontFamily: 'SpaceGrotesk')),
        const H(10),
        Container(
          width: double.maxFinite,
          height: 0.5,
          color: Colors.white,
        ),
      ],
    );
  }
}
