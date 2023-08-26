import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'profile_photo_widget.dart';

class AboutWidget extends StatelessWidget {
  const AboutWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 48, vertical: 24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const SizedBox.shrink(),
          Column(
            children: [
              const ProfilePhotoWidget(),
              const SizedBox(height: 12),
              Text(
                "Engenheiro da Computação",
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Kristhyan de Matos Maia",
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
              ),
              const SizedBox(height: 12),
              Text(
                'Tenho me dedicado a produzir softwares de alto desempenho, mantendo um ambiente de trabalho saudável e valorizando a manutenção do código. Busco constantemente implementar metodologias, conceitos, estruturas e arquiteturas que contribuam para o sucesso dos projetos. Além disso, acredito que estabelecer responsabilidades, respeito e metas claras é fundamental para o crescimento profissional e empresarial.',
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
              SvgPicture.asset(
                'assets/icons/github.svg',
                semanticsLabel: 'GitHub',
              ),
              const SizedBox(width: 12),
              SvgPicture.asset(
                'assets/icons/whatsapp.svg',
                semanticsLabel: 'WhatsApp',
              ),
              const SizedBox(width: 12),
              SvgPicture.asset(
                'assets/icons/linkedin.svg',
                semanticsLabel: 'Linkedin',
              ),
            ],
          ),
          Column(
            children: [
              Text(
                'Repositório no GitHub',
                style: Theme.of(context).textTheme.labelMedium,
              ),
              Text(
                ' Portfólio -  Kristhyan Matos @ 2023',
                style: Theme.of(context).textTheme.labelMedium,
              )
            ],
          )
        ],
      ),
    );
  }
}
