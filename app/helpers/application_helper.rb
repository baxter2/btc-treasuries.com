module ApplicationHelper
  def entity_svg_tag(entity)
    case entity
    when Country
      inline_svg_tag "svg/countries/#{entity.alpha3}.svg", class: "h-10 w-10 rounded-lg"
    when PublicCompany
      inline_svg_tag "svg/public-companies/#{entity.short_ticker.downcase}.svg", class: "h-10 w-10 rounded-lg"
    when PrivateCompany
      inline_svg_tag "svg/private-companies/#{entity.permalink}.svg", class: "h-10 w-10 rounded-lg"
    end
  end

   def entity_link_or_blank(entity)
    case entity
    when Country
      link_to entity.name, treasuries_country_path(entity.permalink), class: "hover:underline"
    when PublicCompany
      link_to entity.name, treasuries_public_company_path(entity.permalink), class: "hover:underline"
    when PrivateCompany
      link_to entity.name, treasuries_private_company_path(entity.permalink), class: "hover:underline"
    end
  end

   def entity_sub_link_or_blank(entity)
    case entity
    when Country
      link_to entity.alpha3, treasuries_country_path(entity.permalink), class: "hover:underline"
    when PublicCompany
      link_to entity.long_ticker, treasuries_public_company_path(entity.permalink), class: "hover:underline"
    when PrivateCompany
      ""
    end
  end
end
