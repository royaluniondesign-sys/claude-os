# /shopify:section

Scaffold a new Shopify Online Store 2.0 section with schema, Liquid, and CSS.

## Usage
```
/shopify:section [name]
```

## What this creates
Given `/shopify:section featured-collection`:

```
sections/featured-collection.liquid
assets/section-featured-collection.css
```

## Rules
- Schema must include: `name`, `max_blocks`, `presets` with at least one default
- Use `{% liquid %}` for multi-line logic
- Load section CSS with `{{ 'section-[name].css' | asset_url | stylesheet_tag }}`
- Use `{% render %}` not `{% include %}` for snippets
- Provide sensible schema defaults so section works out-of-the-box
- All images use `image_url` filter with explicit width — never `| img_url`
- Add `loading="lazy"` to all images except the first/hero

## Template structure
```liquid
{{ 'section-[name].css' | asset_url | stylesheet_tag }}

<section class="[name]" id="[name]-{{ section.id }}">
  {%- liquid
    assign heading = section.settings.heading
  -%}
  <!-- content -->
</section>

{% schema %}
{
  "name": "[Section Name]",
  "tag": "section",
  "max_blocks": 12,
  "settings": [
    {
      "type": "text",
      "id": "heading",
      "label": "Heading",
      "default": "Section Heading"
    }
  ],
  "presets": [
    {
      "name": "[Section Name]"
    }
  ]
}
{% endschema %}
```
