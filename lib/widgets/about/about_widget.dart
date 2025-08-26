// ignore_for_file: avoid_web_libraries_in_flutter

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'dart:js' as js;
import 'profile_photo_widget.dart';

class AboutWidget extends StatelessWidget {
  const AboutWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: MediaQuery.of(context).size.width * 0.02,
        vertical: 24,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const SizedBox.shrink(),
          Column(
            children: [
              const ProfilePhotoWidget(),
              const SizedBox(height: 12),
              Text(
                "Kristhyan de Matos Maia",
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Formado em Engenharia da Computação pela Universidade Federal do Sul e Sudeste do Pará [UNIFESSPA], tenho me dedicado a produzir softwares de alto desempenho, mantendo um ambiente de trabalho saudável e valorizando a manutenção do código. Busco constantemente implementar metodologias, conceitos, estruturas e arquiteturas que contribuam para o sucesso dos projetos. Além disso, acredito que estabelecer responsabilidades, respeito e metas claras é fundamental para o crescimento profissional e empresarial.',
                style: Theme.of(context).textTheme.bodyLarge,
                textAlign: TextAlign.justify,
                overflow: TextOverflow.ellipsis,
                maxLines: 12,
              ),
            ],
          ),
          const Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                onTap: () => js.context.callMethod(
                  'open',
                  ['https://github.com/kristhyanmatos'],
                ),
                child: SvgPicture.asset(
                  'assets/icons/github.svg',
                  semanticsLabel: 'GitHub',
                ),
              ),
              const SizedBox(width: 12),
              InkWell(
                onTap: () => js.context.callMethod(
                  'open',
                  ['https://api.whatsapp.com/send?phone=5591985398664'],
                ),
                child: SvgPicture.asset(
                  'assets/icons/whatsapp.svg',
                  semanticsLabel: 'WhatsApp',
                ),
              ),
              const SizedBox(width: 12),
              InkWell(
                onTap: () => js.context.callMethod(
                  'open',
                  ['https://www.linkedin.com/in/kristhyan-de-matos-maia/'],
                ),
                child: SvgPicture.asset(
                  'assets/icons/linkedin.svg',
                  semanticsLabel: 'Linkedin',
                ),
              ),
            ],
          ),
          Column(
            children: [
              InkWell(
                onTap: () => js.context.callMethod(
                  'open',
                  ['https://github.com/kristhyanmatos/portfolio'],
                ),
                child: Text(
                  'Repositório no GitHub',
                  style: Theme.of(context).textTheme.labelMedium,
                ),
              ),
              Text(
                ' Portfólio -  Kristhyan de Matos Maia @ 2023',
                style: Theme.of(context).textTheme.labelMedium,
              )
            ],
          )
        ],
      ),
    );
  }
}
