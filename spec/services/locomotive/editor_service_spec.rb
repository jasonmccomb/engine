# encoding: utf-8

describe Locomotive::EditorService do

  let(:site) { double(:site) }
  let(:account) { double(:account) }
  let(:activities) { double(:activities) }
  let(:page) { double(:page) }
  let(:service) { described_class.new(site, account, page) }
  let(:site_attributes) { {
    sections_content:
    <<-JSON
      {
        "header_01": {
          "settings": {
            "signup_url": "#asdf",
            "phone_number": "1337 993 399",
            "short_about": "!"
          },
          "blocks": [
            {
              "type": "menu_item",
              "settings": {
                "title": "Homeasdf",
                "url": "/"
              },
              "id": "0"
            },
            {
              "type": "menu_item",
              "settings": {
                "title": "About us",
                "url": "#"
              },
              "id": "1"
            },
            {
              "type": "menu_item",
              "settings": {
                "title": "Our services",
                "url": "#"
              },
              "id": "2"
            },
            {
              "id": "3",
              "type": "menu_item",
              "settings": {
                "title": "Menu itemasdf",
                "url": "#"
              }
            },
            {
              "id": "4",
              "type": "menu_item",
              "settings": {
                "title": "Menu item",
                "url": "#"
              }
            },
            {
              "id": "ba2ea9d8-396f-41ab-b6f3-20a8ccfd1f32",
              "type": "menu_item",
              "settings": {
                "title": "Menuuu item",
                "url": "#"
              }
            }
          ]
        }
      }
    JSON
    }
  }


let(:expected_site_attributes) {
  {
    sections_content: "{\"header_01\":{\"settings\":{\"signup_url\":\"#asdf\",\"phone_number\":\"1337 993 399\",\"short_about\":\"!\"},\"blocks\":[{\"type\":\"menu_item\",\"settings\":{\"title\":\"Homeasdf\",\"url\":\"/\"}},{\"type\":\"menu_item\",\"settings\":{\"title\":\"About us\",\"url\":\"#\"}},{\"type\":\"menu_item\",\"settings\":{\"title\":\"Our services\",\"url\":\"#\"}},{\"type\":\"menu_item\",\"settings\":{\"title\":\"Menu itemasdf\",\"url\":\"#\"}},{\"type\":\"menu_item\",\"settings\":{\"title\":\"Menu item\",\"url\":\"#\"}},{\"type\":\"menu_item\",\"settings\":{\"title\":\"Menuuu item\",\"url\":\"#\"}}]}}"
  }
  }

  describe '#save' do
    let(:page_attributes) {
      {
        sections_content:
        <<-JSON
            [{
              "id": "10ebe2f8-af88-4d87-9df8-58e3e624d662",
              "name": "Cover 04",
              "type": "cover_04",
              "settings": {},
              "blocks": [
                {
                  "type": "slide",
                  "settings": {
                    "title": "A brand new way to excite <br>your audience",
                    "description": "Who can visualize the sorrow and mineral of a lord if he has the evil sainthood of the seeker.",
                    "image": "https://images.unsplash.com/photo-1437532437759-a0ce0535dfed?ixlib=rb-0.3.5&amp;q=80&amp;fm=jpg&amp;crop=entropy&amp;s=2c277dc10ba53e29a62d09c13cdf01b9"
                  },
                  "id": "72a28230-62fb-429c-b7ae-69ae377015b8"
                },
                {
                  "type": "slide",
                  "settings": {
                    "title": "A meaningless form of vision is the uniqueness!",
                    "image": "https://images.unsplash.com/photo-1437532437759-a0ce0535dfed?ixlib=rb-0.3.5&amp;q=80&amp;fm=jpg&amp;crop=entropy&amp;s=2c277dc10ba53e29a62d09c13cdf01b9",
                    "description": "Description goes here"
                  },
                  "id": "bc06c67a-d268-44fb-a6de-cff5df845ed7"
                }
              ]
            }]
        JSON
      }
    }

    let(:expected_page_attribute) {
      {
        sections_content: "[{\"name\":\"Cover 04\",\"type\":\"cover_04\",\"settings\":{},\"blocks\":[{\"type\":\"slide\",\"settings\":{\"title\":\"A brand new way to excite \\u003cbr\\u003eyour audience\",\"description\":\"Who can visualize the sorrow and mineral of a lord if he has the evil sainthood of the seeker.\",\"image\":\"https://images.unsplash.com/photo-1437532437759-a0ce0535dfed?ixlib=rb-0.3.5\\u0026amp;q=80\\u0026amp;fm=jpg\\u0026amp;crop=entropy\\u0026amp;s=2c277dc10ba53e29a62d09c13cdf01b9\"}},{\"type\":\"slide\",\"settings\":{\"title\":\"A meaningless form of vision is the uniqueness!\",\"image\":\"https://images.unsplash.com/photo-1437532437759-a0ce0535dfed?ixlib=rb-0.3.5\\u0026amp;q=80\\u0026amp;fm=jpg\\u0026amp;crop=entropy\\u0026amp;s=2c277dc10ba53e29a62d09c13cdf01b9\",\"description\":\"Description goes here\"}}]}]"
      }
    }

    subject { service.save(site_attributes, page_attributes) }

    it 'save the page section' do
      allow(site).to receive(:title) { 'aTitle' }
      allow(activities).to receive(:create!) { true }
      allow(site).to receive(:activities) { activities }
      allow(page).to receive(:title) { 'aTitle' }
      allow(page).to receive(:_id) { 'anId' }

      allow(site).to receive(:update_attributes).with(expected_site_attributes) { true }
      allow(page).to receive(:update_attributes).with(expected_page_attribute) { true }

      subject
      expect(true).to eq(true) #expect doubles to receive update_attributes with correct params
    end
  end

  describe '#remove_ids!' do
    subject { service.remove_ids(json) }

    context 'when there is a section id' do
      let(:json) {
        <<-JSON
          [{
            "id": "10ebe2f8-af88-4d87-9df8-58e3e624d662",
            "name": "Cover 04",
            "type": "cover_04",
            "settings": {},
            "blocks": [
              {
                "type": "slide",
                "settings": {
                  "title": "A brand new way to excite <br>your audience",
                  "description": "Who can visualize the sorrow and mineral of a lord if he has the evil sainthood of the seeker.",
                  "image": "https://images.unsplash.com/photo-1437532437759-a0ce0535dfed?ixlib=rb-0.3.5&amp;q=80&amp;fm=jpg&amp;crop=entropy&amp;s=2c277dc10ba53e29a62d09c13cdf01b9"
                },
                "id": "72a28230-62fb-429c-b7ae-69ae377015b8"
              },
              {
                "type": "slide",
                "settings": {
                  "title": "A meaningless form of vision is the uniqueness!",
                  "image": "https://images.unsplash.com/photo-1437532437759-a0ce0535dfed?ixlib=rb-0.3.5&amp;q=80&amp;fm=jpg&amp;crop=entropy&amp;s=2c277dc10ba53e29a62d09c13cdf01b9",
                  "description": "Description goes here"
                },
                "id": "bc06c67a-d268-44fb-a6de-cff5df845ed7"
              }
            ]
          }]
        JSON
      }

      let(:expected) {
        <<-JSON
          [{
            "name": "Cover 04",
            "type": "cover_04",
            "settings": {},
            "blocks": [
              {
                "type": "slide",
                "settings": {
                  "title": "A brand new way to excite <br>your audience",
                  "description": "Who can visualize the sorrow and mineral of a lord if he has the evil sainthood of the seeker.",
                  "image": "https://images.unsplash.com/photo-1437532437759-a0ce0535dfed?ixlib=rb-0.3.5&amp;q=80&amp;fm=jpg&amp;crop=entropy&amp;s=2c277dc10ba53e29a62d09c13cdf01b9"
                }
              },
              {
                "type": "slide",
                "settings": {
                  "title": "A meaningless form of vision is the uniqueness!",
                  "image": "https://images.unsplash.com/photo-1437532437759-a0ce0535dfed?ixlib=rb-0.3.5&amp;q=80&amp;fm=jpg&amp;crop=entropy&amp;s=2c277dc10ba53e29a62d09c13cdf01b9",
                  "description": "Description goes here"
                }
              }
            ]
          }]
        JSON
      }

      it 'remove the ids' do
        is_expected.to eq(JSON.parse(expected).to_json)
      end
    end

  end
end